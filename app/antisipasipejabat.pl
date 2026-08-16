:- use_module(library(main)).
:- use_module(library(antisipasipejabat)).

:- initialization(main, main).

main(Argv) :-
    antisipasipejabat:main(Argv).
