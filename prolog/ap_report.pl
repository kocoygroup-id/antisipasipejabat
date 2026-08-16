:- module(ap_report, [print_report/1, print_comparison/1, bar/2]).

:- use_module(library(lists)).
:- use_module(library(apply)).

print_report(R) :-
    S = R.scenario,
    format('~n============================================================~n', []),
    format(' ANTISIPASI PEJABAT - HASIL SIMULASI~n', []),
    format('============================================================~n', []),
    format('Skenario       : ~w~n', [S.name]),
    format('Wilayah        : ~w / ~w (~w)~n', [S.province, S.city, S.scope]),
    format('Isu            : ~w - ~w~n', [S.issue, S.subissue]),
    format('Target tuntutan: ~w~n~n', [S.target]),
    metric('Kemungkinan aksi', R.likelihood, R.likelihood_band),
    metric('Penyebaran', R.spread, R.spread_band),
    metric('Eskalasi', R.escalation, R.escalation_band),
    metric('Tekanan kebijakan', R.political_pressure, '-'),
    metric('Kelanjutan aksi', R.continuation, '-'),
    metric('Confidence model', R.confidence, 'maks 68 pada model heuristik'),
    format('~nState            : ~w~n', [R.predicted_state]),
    format('Skala            : ~w~n', [R.predicted_scale]),
    format('Turnout bucket   : ~w~n', [R.crowd_bucket]),
    format('Policy outlook   : ~w~n', [R.policy_outlook]),
    format('Status model     : ~w~n', [R.model_status]),
    format('~nFaktor pendorong utama:~n', []),
    forall(member(F, R.top_factors),
           format('  + ~w: ~1f poin (~w)~n', [F.label, F.contribution, F.field])),
    format('~nFaktor mitigasi yang dimodelkan:~n', []),
    forall(member(FP, R.protective_factors),
           format('  - ~w: nilai ~w, efek -~1f~n', [FP.label, FP.value, FP.effect])),
    format('~nCatatan hukum:~n  ~w~n', [R.legal_note]),
    format('~nPENTING: skor adalah estimasi heuristik, bukan fakta atau probabilitas empiris.~n', []),
    format('Tool tidak boleh dipakai untuk menarget individu, membatasi hak sipil, atau merancang represi.~n', []).

metric(Label, Value, Band) :-
    bar(Value, B),
    format('~w: ~w/100  ~w  (~w)~n', [Label, Value, B, Band]).

bar(Value, Bar) :-
    Filled is round(Value/5), Empty is 20-Filled,
    length(Fs, Filled), maplist(=('█'), Fs), atomic_list_concat(Fs, '', A),
    length(Es, Empty), maplist(=('░'), Es), atomic_list_concat(Es, '', B),
    atom_concat(A, B, Bar).

print_comparison(Results) :-
    format('~nPERBANDINGAN RESPONS KEBIJAKAN (analisis, bukan rekomendasi penindakan)~n', []),
    format('------------------------------------------------------------------~n', []),
    forall(member(X, Results),
           format('~w~n  likelihood=~w spread=~w escalation=~w pressure=~w~n',
                  [X.variant, X.report.likelihood, X.report.spread,
                   X.report.escalation, X.report.political_pressure])).
