:- module(ap_defaults,
          [ default_scenario/1,
            issue/2,
            scope/2,
            target/2,
            yes_no/2,
            numeric_field/4,
            scenario_numeric_keys/1
          ]).

/** <module> Nilai default dan katalog domain. */

default_scenario(scenario{
    name:"Skenario Baru",
    scope:kota,
    province:"DKI Jakarta",
    city:"Jakarta",
    issue:kebijakan_publik,
    subissue:"kebijakan yang memicu penolakan",
    target:pemerintah_pusat,
    grievance:50,
    trigger:50,
    salience:50,
    online:40,
    coalition:35,
    organization:40,
    economic_stress:50,
    institutional_distrust:50,
    incident_shock:0,
    recent_precedent:30,
    media_attention:40,
    public_support:50,
    regional_relevance:50,
    govt_communication:50,
    govt_responsiveness:50,
    organizer_control:65,
    intervention_pressure:20,
    duration_days:1,
    notified:unknown,
    evidence_quality:50,
    population_millions:2.0,
    seed:1998
}).

issue(1, ekonomi).
issue(2, ketenagakerjaan).
issue(3, korupsi_dan_integritas).
issue(4, pendidikan).
issue(5, kebijakan_publik).
issue(6, pemilu_dan_demokrasi).
issue(7, lingkungan_dan_agraria).
issue(8, ham_dan_kebebasan_sipil).
issue(9, pelayanan_publik).
issue(10, sektoral_lokal).
issue(11, bencana_dan_respons).
issue(12, lainnya).

scope(1, lokal).
scope(2, kota).
scope(3, provinsi).
scope(4, multi_provinsi).
scope(5, nasional).

target(1, pemerintah_pusat).
target(2, pemerintah_daerah).
target(3, dpr_dprd).
target(4, lembaga_negara).
target(5, perusahaan).
target(6, kampus).
target(7, lainnya).

yes_no(1, yes).
yes_no(2, no).
yes_no(3, unknown).

numeric_field(grievance, 'Akumulasi keluhan publik', 0, 100).
numeric_field(trigger, 'Kekuatan pemicu langsung', 0, 100).
numeric_field(salience, 'Seberapa penting isu bagi publik', 0, 100).
numeric_field(online, 'Momentum percakapan/penyebaran daring', 0, 100).
numeric_field(coalition, 'Kekuatan koalisi lintas kelompok', 0, 100).
numeric_field(organization, 'Kapasitas organisasi/mobilisasi', 0, 100).
numeric_field(economic_stress, 'Tekanan ekonomi', 0, 100).
numeric_field(institutional_distrust, 'Ketidakpercayaan institusional', 0, 100).
numeric_field(incident_shock, 'Dampak insiden pemicu tambahan', 0, 100).
numeric_field(recent_precedent, 'Efek preseden demonstrasi terbaru', 0, 100).
numeric_field(media_attention, 'Perhatian media', 0, 100).
numeric_field(public_support, 'Dukungan publik pada tuntutan', 0, 100).
numeric_field(regional_relevance, 'Relevansi isu lintas wilayah', 0, 100).
numeric_field(govt_communication, 'Kualitas komunikasi pemerintah', 0, 100).
numeric_field(govt_responsiveness, 'Responsivitas/dialog kebijakan', 0, 100).
numeric_field(organizer_control, 'Kemampuan penyelenggara menjaga disiplin aksi', 0, 100).
numeric_field(intervention_pressure, 'Tekanan/intervensi terhadap aksi', 0, 100).
numeric_field(evidence_quality, 'Kualitas bukti/input yang dimiliki', 0, 100).

scenario_numeric_keys([
    grievance, trigger, salience, online, coalition, organization,
    economic_stress, institutional_distrust, incident_shock,
    recent_precedent, media_attention, public_support, regional_relevance,
    govt_communication, govt_responsiveness, organizer_control,
    intervention_pressure, evidence_quality
]).
