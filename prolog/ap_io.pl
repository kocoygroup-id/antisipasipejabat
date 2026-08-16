:- module(ap_io,
          [ save_scenario/2,
            load_scenario/2,
            export_report_json/2,
            ensure_extension/3
          ]).

:- use_module(library(http/json)).
:- use_module(ap_validation).

save_scenario(File0, Scenario0) :-
    ensure_extension(File0, '.ap.pl', File),
    ap_validation:normalized_scenario(Scenario0, Scenario),
    setup_call_cleanup(
        open(File, write, Out, [encoding(utf8)]),
        write_term(Out, Scenario, [quoted(true), fullstop(true), nl(true)]),
        close(Out)).

load_scenario(File, Scenario) :-
    setup_call_cleanup(
        open(File, read, In, [encoding(utf8)]),
        read_term(In, Term, [syntax_errors(error)]),
        close(In)),
    ( is_dict(Term) -> ap_validation:normalized_scenario(Term, Scenario)
    ; throw(error(type_error(scenario_dict, Term), load_scenario/2))
    ).

export_report_json(File0, Report0, File) :-
    ensure_extension(File0, '.json', File),
    json_safe_report(Report0, Report),
    setup_call_cleanup(
        open(File, write, Out, [encoding(utf8)]),
        json_write_dict(Out, Report, [width(0)]),
        close(Out)).

json_safe_report(Report0, Report) :-
    ( is_dict(Report0), del_dict(contributions, Report0, _, R1) -> Report = R1
    ; Report = Report0
    ).

export_report_json(File0, Report) :- export_report_json(File0, Report, _).

ensure_extension(File0, Ext, File) :-
    string(File0), !,
    atom_string(A0, File0),
    ensure_extension(A0, Ext, File).
ensure_extension(File0, Ext, File) :-
    atom(File0),
    ( sub_atom(File0, _, _, 0, Ext) -> File = File0
    ; atom_concat(File0, Ext, File)
    ).
