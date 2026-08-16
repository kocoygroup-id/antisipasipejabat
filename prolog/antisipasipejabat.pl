:- module(antisipasipejabat,
          [ main/1,
            start/0,
            simulate/2,
            score/2,
            default_scenario/1,
            version/1
          ]).

/** <module> Antisipasi Pejabat

API publik untuk Antisipasi Pejabat v0.1.0.0.

Tool ini mensimulasikan risiko demonstrasi pada tingkat agregat. Ia tidak
mengidentifikasi individu, tidak mengumpulkan data pribadi, dan tidak memberikan
rekomendasi penindakan terhadap demonstran.
*/

:- use_module(ap_version, []).
:- use_module(ap_defaults, []).
:- use_module(ap_model, []).
:- use_module(ap_cli, []).

version(V) :- ap_version:version(V).
default_scenario(S) :- ap_defaults:default_scenario(S).
score(S, R) :- ap_model:score(S, R).
simulate(S, R) :- ap_model:score(S, R).
start :- ap_cli:start.

main(Argv) :- ap_cli:main(Argv).
