:- module(ap_compare, [compare_responses/2]).

:- use_module(ap_model).
:- use_module(ap_validation).

/** Bandingkan respons kebijakan tanpa memberi rekomendasi represif.
    Skenario intervensi tinggi hanya ditampilkan sebagai risk stress-test. */
compare_responses(Input, Results) :-
    ap_validation:normalized_scenario(Input, S),
    variants(S, Variants),
    findall(_{variant:Name, report:R},
            ( member(Name-V, Variants), ap_model:score(V, R) ), Results).

variants(S, [
    'baseline'-S,
    'dialog_dan_respons_cepat'-D,
    'klarifikasi_tinggi'-K,
    'review_atau_penundaan_kebijakan'-P,
    'respons_minimal'-M,
    'stress_test_intervensi_tinggi_bukan_rekomendasi'-H
]) :-
    put_dict(_{govt_responsiveness:82, govt_communication:78, intervention_pressure:15}, S, D),
    put_dict(_{govt_communication:88, govt_responsiveness:60}, S, K),
    put_dict(_{govt_responsiveness:90, trigger:35, grievance:45}, S, P),
    put_dict(_{govt_communication:20, govt_responsiveness:20}, S, M),
    put_dict(_{intervention_pressure:90, govt_responsiveness:20}, S, H).
