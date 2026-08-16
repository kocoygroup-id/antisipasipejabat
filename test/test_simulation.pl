:- begin_tests(ap_simulation).
:- use_module(library(antisipasipejabat)).
:- use_module(library(ap_simulation)).

test(deterministic_seed) :-
    default_scenario(S), next_day(S,N1,E1), next_day(S,N2,E2),
    assertion(N1 == N2), assertion(E1 == E2).

:- end_tests(ap_simulation).
