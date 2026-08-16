:- module(ap_model,
          [ score/2,
            likelihood_score/3,
            spread_score/3,
            escalation_score/3,
            pressure_score/3,
            crowd_bucket/2,
            risk_band/2,
            predicted_state/3,
            top_factors/3
          ]).

/** <module> Model heuristik explainable Antisipasi Pejabat.

Koefisien v0.1.0.0 adalah bobot heuristik terdokumentasi. Bobot belum merupakan
hasil estimasi kausal dan tidak boleh dipresentasikan sebagai probabilitas empiris
terkalibrasi tanpa evaluasi data historis yang sesuai.
*/

:- use_module(library(lists)).
:- use_module(ap_validation).
:- use_module(ap_legal).

positive_weight(grievance,              0.14, 'akumulasi keluhan').
positive_weight(trigger,                0.13, 'pemicu langsung').
positive_weight(salience,               0.10, 'kepentingan isu').
positive_weight(online,                 0.08, 'momentum daring').
positive_weight(coalition,              0.08, 'koalisi lintas kelompok').
positive_weight(organization,           0.07, 'kapasitas mobilisasi').
positive_weight(economic_stress,        0.07, 'tekanan ekonomi').
positive_weight(institutional_distrust, 0.08, 'ketidakpercayaan institusional').
positive_weight(incident_shock,         0.08, 'insiden pemicu tambahan').
positive_weight(recent_precedent,       0.04, 'preseden aksi terbaru').
positive_weight(media_attention,        0.05, 'perhatian media').
positive_weight(public_support,         0.05, 'dukungan publik').
positive_weight(regional_relevance,     0.03, 'relevansi lintas wilayah').

protective_weight(govt_communication,   0.06, 'komunikasi pemerintah').
protective_weight(govt_responsiveness,  0.08, 'responsivitas/dialog').

spread_weight(online,             0.20, 'momentum daring').
spread_weight(coalition,          0.15, 'koalisi').
spread_weight(salience,           0.14, 'kepentingan isu').
spread_weight(regional_relevance, 0.18, 'relevansi lintas wilayah').
spread_weight(public_support,     0.12, 'dukungan publik').
spread_weight(media_attention,    0.11, 'perhatian media').
spread_weight(recent_precedent,   0.10, 'preseden aksi').

score(Input, Report) :-
    ap_validation:normalized_scenario(Input, S),
    likelihood_score(S, Likelihood, LikContrib),
    spread_score(S, Spread, SpreadContrib),
    escalation_score(S, Escalation, EscContrib),
    pressure_score(S, Pressure, _),
    confidence_score(S, Confidence),
    risk_band(Likelihood, LikBand),
    risk_band(Spread, SpreadBand),
    risk_band(Escalation, EscBand),
    predicted_state(Likelihood, Escalation, State),
    predicted_scale(S, Likelihood, Spread, Scale),
    turnout_index(S, Likelihood, Spread, TurnoutIndex),
    crowd_bucket(TurnoutIndex, CrowdBucket),
    continuation_score(S, Likelihood, Spread, Continue),
    policy_outlook(S, Likelihood, Pressure, Outlook),
    ap_legal:legal_note(S, Legal),
    top_factors(LikContrib, 5, TopPositive),
    protective_factors(S, Protective),
    Report = report{
        scenario:S,
        likelihood:Likelihood,
        likelihood_band:LikBand,
        spread:Spread,
        spread_band:SpreadBand,
        escalation:Escalation,
        escalation_band:EscBand,
        political_pressure:Pressure,
        confidence:Confidence,
        predicted_state:State,
        predicted_scale:Scale,
        crowd_bucket:CrowdBucket,
        continuation:Continue,
        policy_outlook:Outlook,
        legal_note:Legal,
        top_factors:TopPositive,
        protective_factors:Protective,
        contributions:_{likelihood:LikContrib, spread:SpreadContrib, escalation:EscContrib},
        model_status:'HEURISTIC_UNCALIBRATED_V0_1'
    }.

likelihood_score(S, Score, Contributions) :-
    findall(C-Label-Key,
            ( positive_weight(Key, W, Label),
              get_dict(Key, S, V),
              C is V*W
            ), Pos),
    sum_contributions(Pos, P),
    findall(C-Label-Key,
            ( protective_weight(Key, W, Label),
              get_dict(Key, S, V),
              C is -(V*W)
            ), Neg),
    sum_contributions(Neg, N),
    scope_likelihood_bonus(S.scope, SB),
    Raw is 8 + P + N + SB,
    ap_validation:clamp(0, 100, Raw, Capped),
    Score is round(Capped),
    append(Pos, Neg, Contributions).

spread_score(S, Score, Contributions) :-
    findall(C-Label-Key,
            ( spread_weight(Key, W, Label),
              get_dict(Key, S, V),
              C is V*W
            ), Cs),
    sum_contributions(Cs, Base),
    scope_spread_bonus(S.scope, Bonus),
    Raw is Base + Bonus,
    ap_validation:clamp(0, 100, Raw, Capped),
    Score is round(Capped),
    Contributions = Cs.

escalation_score(S, Score, Contributions) :-
    DurationPressure is min(100, S.duration_days*12),
    LowControl is 100-S.organizer_control,
    LowResponse is 100-S.govt_responsiveness,
    Pairs = [
        grievance-0.14-'akumulasi keluhan',
        incident_shock-0.20-'insiden pemicu tambahan',
        intervention_pressure-0.18-'tekanan/intervensi',
        institutional_distrust-0.11-'ketidakpercayaan institusional',
        trigger-0.10-'pemicu langsung'
    ],
    findall(C-Label-Key,
            ( member(Key-W-Label, Pairs),
              get_dict(Key, S, V), C is V*W
            ), C0),
    C1 is DurationPressure*0.08,
    C2 is LowControl*0.10,
    C3 is LowResponse*0.09,
    Extra = [C1-'durasi tekanan'-duration_days,
             C2-'kontrol penyelenggara rendah'-organizer_control,
             C3-'respons kebijakan rendah'-govt_responsiveness],
    append(C0, Extra, Contributions),
    sum_contributions(Contributions, Raw0),
    Raw is Raw0*0.94,
    ap_validation:clamp(0, 100, Raw, Capped),
    Score is round(Capped).

pressure_score(S, Score, Contributions) :-
    Pairs = [
        public_support-0.24-'dukungan publik',
        salience-0.18-'kepentingan isu',
        coalition-0.15-'koalisi',
        media_attention-0.13-'perhatian media',
        spread_proxy-0.15-'potensi penyebaran',
        grievance-0.15-'akumulasi keluhan'
    ],
    spread_score(S, Spread, _),
    findall(C-Label-Key,
            ( member(Key-W-Label, Pairs),
              pressure_value(Key, S, Spread, V), C is V*W
            ), Contributions),
    sum_contributions(Contributions, Raw),
    ap_validation:clamp(0, 100, Raw, Capped),
    Score is round(Capped).

pressure_value(spread_proxy, _S, Spread, Spread) :- !.
pressure_value(Key, S, _Spread, V) :- get_dict(Key, S, V).

confidence_score(S, Score) :-
    Q = S.evidence_quality,
    Base is 25 + Q*0.40,
    ( S.incident_shock > 0 -> Bonus = 3 ; Bonus = 0 ),
    Raw is Base + Bonus,
    ap_validation:clamp(20, 68, Raw, Capped),
    Score is round(Capped).

continuation_score(S, Likelihood, Spread, Score) :-
    Raw is Likelihood*0.42 + Spread*0.31 + S.grievance*0.17 +
           (100-S.govt_responsiveness)*0.10,
    ap_validation:clamp(0, 100, Raw, Capped),
    Score is round(Capped).

policy_outlook(S, _Likelihood, Pressure, Outlook) :-
    R = S.govt_responsiveness,
    ( Pressure >= 75, R >= 60 -> Outlook = 'peluang_konsesi_atau_review_tinggi'
    ; Pressure >= 60, R >= 40 -> Outlook = 'peluang_dialog_atau_penyesuaian_moderat'
    ; Pressure >= 60, R < 40  -> Outlook = 'tekanan_tinggi_respons_rendah'
    ; Pressure < 40           -> Outlook = 'tekanan_kebijakan_relatively_rendah'
    ; Outlook = 'hasil_belum_jelas'
    ).

predicted_scale(S, Likelihood, Spread, Scale) :-
    Base is Likelihood*0.45 + Spread*0.55,
    scope_scale_adjust(S.scope, A), X is Base + A,
    ( X < 35 -> Scale = 'terbatas/lokal'
    ; X < 52 -> Scale = 'kota/area'
    ; X < 68 -> Scale = 'lintas-kota'
    ; X < 82 -> Scale = 'multi-provinsi'
    ; Scale = 'nasional-potensial'
    ).

turnout_index(S, Likelihood, Spread, Index) :-
    PopFactor is min(100, 25 + log(S.population_millions+1)*22),
    Raw is Likelihood*0.36 + Spread*0.22 + S.organization*0.17 +
           S.public_support*0.15 + PopFactor*0.10,
    ap_validation:clamp(0, 100, Raw, Capped),
    Index is round(Capped).

% Mapping indeks internal ke bucket ukuran ACLED. Ini bukan estimasi jumlah presisi.
crowd_bucket(I, 'very small (<20)') :- I < 25, !.
crowd_bucket(I, 'small (20-99)') :- I < 42, !.
crowd_bucket(I, 'medium (100-999)') :- I < 62, !.
crowd_bucket(I, 'large (1,000-9,999)') :- I < 80, !.
crowd_bucket(_, 'massive (10,000+)').

risk_band(S, sangat_rendah) :- S < 20, !.
risk_band(S, rendah) :- S < 40, !.
risk_band(S, sedang) :- S < 60, !.
risk_band(S, tinggi) :- S < 80, !.
risk_band(_, sangat_tinggi).

predicted_state(L, _E, 'tidak_ada_aksi_besar_terdeteksi') :- L < 35, !.
predicted_state(_L, E, 'peaceful_protest_paling_mungkin') :- E < 35, !.
predicted_state(_L, E, 'risiko_protest_with_intervention') :- E < 58, !.
predicted_state(_L, E, 'risiko_excessive_force_or_violent_demonstration_meningkat') :- E >= 58.

scope_likelihood_bonus(lokal, 0) :- !.
scope_likelihood_bonus(kota, 1) :- !.
scope_likelihood_bonus(provinsi, 2) :- !.
scope_likelihood_bonus(multi_provinsi, 4) :- !.
scope_likelihood_bonus(nasional, 5) :- !.
scope_likelihood_bonus(_, 0).

scope_spread_bonus(lokal, -8) :- !.
scope_spread_bonus(kota, -3) :- !.
scope_spread_bonus(provinsi, 1) :- !.
scope_spread_bonus(multi_provinsi, 5) :- !.
scope_spread_bonus(nasional, 8) :- !.
scope_spread_bonus(_, 0).

scope_scale_adjust(lokal, -12) :- !.
scope_scale_adjust(kota, -5) :- !.
scope_scale_adjust(provinsi, 0) :- !.
scope_scale_adjust(multi_provinsi, 8) :- !.
scope_scale_adjust(nasional, 12) :- !.
scope_scale_adjust(_, 0).

sum_contributions(Cs, Sum) :-
    findall(V, member(V-_-_, Cs), Vs), sum_list(Vs, Sum).

top_factors(Contributions, N, Top) :-
    include(positive_contribution, Contributions, Positive),
    predsort(compare_contrib_desc, Positive, Sorted),
    take(N, Sorted, Top0),
    maplist(contrib_dict, Top0, Top).

positive_contribution(V-_-_) :- V > 0.
compare_contrib_desc(Order, A-_-_, B-_-_) :- compare(Order, B, A).

take(0, _Xs, []) :- !.
take(_, [], []) :- !.
take(N, [X|Xs], [X|Ys]) :- N1 is N-1, take(N1, Xs, Ys).

contrib_dict(V-Label-Key, _{field:Key, label:Label, contribution:Rounded}) :-
    Rounded is round(V*10)/10.

protective_factors(S, Factors) :-
    findall(_{field:Key,label:Label,value:V,effect:Effect},
            ( protective_weight(Key, W, Label),
              get_dict(Key, S, V), Effect is round(V*W*10)/10
            ), Factors).
