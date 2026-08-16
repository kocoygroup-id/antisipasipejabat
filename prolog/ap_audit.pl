:- module(ap_audit, [record_report/1, show_audit/0, audit_file/1]).

:- use_module(library(filesex)).

state_dir(Dir) :-
    expand_file_name('~/.antisipasipejabat', [Dir]).

audit_file(File) :-
    state_dir(Dir),
    make_directory_path(Dir),
    directory_file_path(Dir, 'audit.log', File).

record_report(R) :-
    audit_file(File),
    get_time(Now),
    format_time(string(Stamp), '%FT%T%z', Now),
    term_hash(R.scenario, Hash),
    setup_call_cleanup(
        open(File, append, Out, [encoding(utf8)]),
        format(Out, '~s\t~w\t~w\t~w\t~w\t~w~n',
               [Stamp, Hash, R.likelihood, R.spread, R.escalation, R.confidence]),
        close(Out)).

show_audit :-
    audit_file(File),
    ( exists_file(File) ->
        setup_call_cleanup(open(File, read, In, [encoding(utf8)]), copy_stream_data(In, current_output), close(In))
    ; format('Belum ada audit log.~n', [])
    ).
