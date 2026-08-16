:- module(ap_validation,
          [ validate_scenario/2,
            clamp/4,
            safe_number/2,
            safe_atom/2,
            normalized_scenario/2
          ]).

:- use_module(library(apply)).
:- use_module(ap_defaults).

clamp(Min, Max, X, Y) :-
    ( X < Min -> Y = Min
    ; X > Max -> Y = Max
    ; Y = X
    ).

safe_number(X, N) :- number(X), !, N = X.
safe_number(X, N) :- atom(X), atom_number(X, N), !.
safe_number(X, N) :- string(X), number_string(N, X), !.

safe_atom(X, A) :- atom(X), !, A = X.
safe_atom(X, A) :- string(X), !, atom_string(A, X).

normalized_scenario(In, Out) :-
    ap_defaults:default_scenario(D),
    ( is_dict(In) -> put_dict(In, D, Merged) ; Merged = D ),
    normalize_numeric_fields(Merged, Out0),
    normalize_misc(Out0, Out).

normalize_numeric_fields(S0, S) :-
    ap_defaults:scenario_numeric_keys(Keys),
    foldl(normalize_numeric, Keys, S0, S).

normalize_numeric(Key, S0, S) :-
    get_dict(Key, S0, Raw),
    ( safe_number(Raw, N0) -> true ; N0 = 50 ),
    clamp(0, 100, N0, N),
    put_dict(Key, S0, N, S).

normalize_misc(S0, S) :-
    normalize_duration(S0, S1),
    normalize_population(S1, S2),
    normalize_seed(S2, S3),
    normalize_category(scope, S3, S4),
    normalize_category(issue, S4, S5),
    normalize_category(target, S5, S6),
    normalize_category(notified, S6, S).

normalize_duration(S0, S) :-
    get_dict(duration_days, S0, Raw),
    ( safe_number(Raw, N0) -> N1 is round(N0) ; N1 = 1 ),
    clamp(1, 365, N1, N),
    put_dict(duration_days, S0, N, S).

normalize_population(S0, S) :-
    get_dict(population_millions, S0, Raw),
    ( safe_number(Raw, N0) -> true ; N0 = 2.0 ),
    clamp(0.01, 300.0, N0, N),
    put_dict(population_millions, S0, N, S).

normalize_seed(S0, S) :-
    get_dict(seed, S0, Raw),
    ( safe_number(Raw, N0) -> N is round(N0) ; N = 1998 ),
    put_dict(seed, S0, N, S).

normalize_category(Key, S0, S) :-
    get_dict(Key, S0, Raw),
    ( safe_atom(Raw, A) -> true ; A = unknown ),
    put_dict(Key, S0, A, S).

validate_scenario(In, Errors) :-
    ( is_dict(In) -> E0 = [] ; E0 = ['Skenario harus berupa dict SWI-Prolog'] ),
    required_keys(Keys),
    findall(Msg,
            ( member(K, Keys),
              ( get_dict(K, In, _) -> fail
              ; format(string(Msg), 'Field wajib hilang: ~w', [K])
              )
            ), Missing),
    append(E0, Missing, Errors).

required_keys([name, scope, province, city, issue, subissue, target]).
