:- use_module(library(main)).

:- initialization(main, main).

main(_) :-
    load_files(
        ['test/test_model.pl',
         'test/test_legal.pl',
         'test/test_io.pl',
         'test/test_simulation.pl'],
        [silent(true)]
    ),
    ( run_tests -> halt(0) ; halt(1) ).
