:- module(ap_calibration, [evaluate_csv/2, print_evaluation/1]).

/** <module> Evaluasi historis sederhana.

CSV harus berisi fitur model dan actual_protest (0/1). Modul ini MENGUJI model,
bukan melatih ulang bobot. Ini sengaja agar v0.1 tidak berpura-pura terkalibrasi.
*/

:- use_module(library(csv)).
:- use_module(library(lists)).
:- use_module(library(apply)).
:- use_module(library(pairs)).
:- use_module(ap_defaults).
:- use_module(ap_model).
:- use_module(ap_validation).

evaluate_csv(File, Summary) :-
    csv_read_file(File, Rows, [functor(row), strip(true)]),
    Rows = [Header|Data],
    Header =.. [_|Names0], maplist(to_atom, Names0, Names),
    findall(Pred-Actual,
            ( member(Row, Data),
              Row =.. [_|Values],
              pairs_keys_values(Pairs, Names, Values),
              row_scenario(Pairs, S, Actual),
              ap_model:score(S, R),
              Pred is R.likelihood/100.0
            ), PairsPA),
    summarize(PairsPA, Summary).

row_scenario(Pairs, S, Actual) :-
    ap_defaults:default_scenario(D),
    model_feature_keys(Keys),
    foldl(apply_pair(Pairs), Keys, D, S),
    ( memberchk(actual_protest-A0, Pairs), ap_validation:safe_number(A0, A1), A1 >= 0.5 -> Actual=1 ; Actual=0 ).

apply_pair(Pairs, Key, S0, S) :-
    ( memberchk(Key-Raw, Pairs), ap_validation:safe_number(Raw, N) -> put_dict(Key, S0, N, S)
    ; S = S0
    ).

model_feature_keys([grievance,trigger,salience,online,coalition,organization,
    economic_stress,institutional_distrust,incident_shock,recent_precedent,
    media_attention,public_support,regional_relevance,govt_communication,
    govt_responsiveness,organizer_control,intervention_pressure,evidence_quality]).

to_atom(X, A) :- atom(X), !, A=X.
to_atom(X, A) :- string(X), !, atom_string(A, X).
to_atom(X, A) :- term_to_atom(X, A).

summarize([], _{events:0, accuracy:null, brier:null, warning:'tidak ada data'}).
summarize(Pairs, Summary) :-
    length(Pairs, N),
    findall(C, (member(P-A,Pairs), predicted_class(P,PC), (PC=:=A -> C=1 ; C=0)), Cs),
    sum_list(Cs, Correct), Accuracy is Correct/N,
    findall(B, (member(P-A,Pairs), B is (P-A)*(P-A)), Bs), sum_list(Bs, BSum), Brier is BSum/N,
    Summary = _{events:N, accuracy:Accuracy, brier:Brier,
                warning:'evaluasi in-sample hanya bermakna bila CSV benar-benar historis dan fitur ditentukan tanpa melihat outcome'}.

predicted_class(P, 1) :- P >= 0.5, !.
predicted_class(_, 0).

print_evaluation(S) :-
    format('Events  : ~w~n', [S.events]),
    format('Accuracy: ~w~n', [S.accuracy]),
    format('Brier   : ~w~n', [S.brier]),
    format('Catatan : ~w~n', [S.warning]).
