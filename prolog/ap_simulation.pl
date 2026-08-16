:- module(ap_simulation, [next_day/3, timeline/4]).

:- use_module(library(random)).
:- use_module(ap_validation).
:- use_module(ap_model).

next_day(Input, Next, Event) :-
    ap_validation:normalized_scenario(Input, S),
    Seed0 is S.seed + S.duration_days*7919,
    set_random(seed(Seed0)),
    random_between(-5, 8, OnlineJ),
    random_between(-4, 7, MediaJ),
    random_between(-3, 5, CoalitionJ),
    random_between(-2, 5, SupportJ),
    decay_incident(S.incident_shock, Incident1),
    adjust(S.online, OnlineJ, Online1),
    adjust(S.media_attention, MediaJ, Media1),
    adjust(S.coalition, CoalitionJ, Coalition1),
    adjust(S.public_support, SupportJ, Support1),
    D1 is S.duration_days + 1,
    Seed1 is S.seed + 1,
    put_dict(_{online:Online1, media_attention:Media1,
               coalition:Coalition1, public_support:Support1,
               incident_shock:Incident1, duration_days:D1, seed:Seed1}, S, Next0),
    policy_dynamics(Next0, Next),
    ap_model:score(Next, R),
    event_text(R, Event).

adjust(Base, Delta, Value) :-
    Raw is Base + Delta,
    ap_validation:clamp(0, 100, Raw, Value).

decay_incident(X, Y) :- Y0 is X*0.82, ap_validation:clamp(0, 100, Y0, Y).

policy_dynamics(S0, S) :-
    Resp = S0.govt_responsiveness,
    Comm = S0.govt_communication,
    ( Resp >= 70 ->
        G0 is S0.grievance - 5, T0 is S0.trigger - 4,
        adjust(G0, 0, G), adjust(T0, 0, T),
        put_dict(_{grievance:G, trigger:T}, S0, S)
    ; Comm < 30, Resp < 30 ->
        G0 is S0.grievance + 3, adjust(G0, 0, G),
        put_dict(grievance, S0, G, S)
    ; S = S0
    ).

event_text(R, Text) :-
    format(string(Text),
           'Hari berikutnya: likelihood ~w/100, spread ~w/100, escalation ~w/100, state ~w.',
           [R.likelihood, R.spread, R.escalation, R.predicted_state]).

timeline(S, 0, [R], []) :- !, ap_model:score(S, R).
timeline(S, Days, [R|Rs], [Event|Events]) :-
    Days > 0,
    ap_model:score(S, R),
    next_day(S, N, Event),
    D1 is Days-1,
    timeline(N, D1, Rs, Events).
