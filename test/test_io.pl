:- begin_tests(ap_io).
:- use_module(library(antisipasipejabat)).
:- use_module(library(ap_io)).
:- use_module(library(http/json)).

test(roundtrip, [cleanup((exists_file('tmp_test.ap.pl') -> delete_file('tmp_test.ap.pl') ; true))]) :-
    default_scenario(S), save_scenario('tmp_test',S), load_scenario('tmp_test.ap.pl',S2),
    assertion(S2.grievance =:= S.grievance),
    assertion(S2.issue == S.issue).


test(export_json, [cleanup((exists_file('tmp_report.json') -> delete_file('tmp_report.json') ; true))]) :-
    default_scenario(S), score(S,R), export_report_json('tmp_report',R),
    setup_call_cleanup(open('tmp_report.json', read, In, [encoding(utf8)]),
                       json_read_dict(In, J), close(In)),
    assertion(J.likelihood =:= R.likelihood),
    assertion(\+ get_dict(contributions, J, _)).

:- end_tests(ap_io).
