:- begin_tests(ap_model).
:- use_module(library(antisipasipejabat), [default_scenario/1, score/2]).
:- use_module(library(ap_model), [crowd_bucket/2]).

low_scenario(S) :-
    default_scenario(D),
    put_dict(_{grievance:10,trigger:10,salience:15,online:5,coalition:5,organization:10,
               economic_stress:20,institutional_distrust:20,incident_shock:0,recent_precedent:5,
               media_attention:10,public_support:20,regional_relevance:10,govt_communication:85,
               govt_responsiveness:90,intervention_pressure:5,evidence_quality:80}, D, S).

high_scenario(S) :-
    default_scenario(D),
    put_dict(_{scope:nasional,grievance:90,trigger:90,salience:90,online:85,coalition:80,
               organization:80,economic_stress:85,institutional_distrust:90,incident_shock:60,
               recent_precedent:80,media_attention:90,public_support:85,regional_relevance:95,
               govt_communication:15,govt_responsiveness:10,organizer_control:45,
               intervention_pressure:70,evidence_quality:80}, D, S).

test(score_bounds) :-
    high_scenario(S), score(S,R),
    assertion(R.likelihood >= 0), assertion(R.likelihood =< 100),
    assertion(R.spread >= 0), assertion(R.spread =< 100),
    assertion(R.escalation >= 0), assertion(R.escalation =< 100).

test(monotonic_sanity) :-
    low_scenario(L), high_scenario(H), score(L,RL), score(H,RH),
    assertion(RH.likelihood > RL.likelihood),
    assertion(RH.escalation > RL.escalation).

test(confidence_cap) :-
    high_scenario(S), score(S,R), assertion(R.confidence =< 68).

test(crowd_buckets) :-
    crowd_bucket(10,'very small (<20)'),
    crowd_bucket(30,'small (20-99)'),
    crowd_bucket(50,'medium (100-999)'),
    crowd_bucket(70,'large (1,000-9,999)'),
    crowd_bucket(90,'massive (10,000+)').


test(duration_is_integer_after_normalization) :-
    default_scenario(D), put_dict(duration_days,D,2.7,S), score(S,R),
    assertion(R.scenario.duration_days =:= 3).

:- end_tests(ap_model).
