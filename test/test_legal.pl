:- begin_tests(ap_legal).
:- use_module(library(antisipasipejabat)).
:- use_module(library(ap_legal)).

test(no_notification_not_auto_illegal) :-
    default_scenario(D), put_dict(notified,D,no,S), legal_note(S,Note),
    once(sub_string(Note, _, _, _, 'tidak boleh otomatis')).

:- end_tests(ap_legal).
