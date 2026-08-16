:- module(ap_cli, [main/1, start/0]).

:- use_module(library(lists)).
:- use_module(library(readutil)).
:- use_module(ap_ui).
:- use_module(ap_defaults).
:- use_module(ap_model).
:- use_module(ap_report).
:- use_module(ap_simulation).
:- use_module(ap_compare).
:- use_module(ap_io).
:- use_module(ap_audit).
:- use_module(ap_legal).
:- use_module(ap_reference).
:- use_module(ap_calibration).
:- use_module(ap_version).

main(Argv) :-
    ( Argv = ['--help'|_] -> help
    ; Argv = ['--version'|_] -> ap_version:version_string(V), format('~w~n', [V])
    ; Argv = ['simulate', File|_] -> cli_simulate_file(File)
    ; Argv = ['evaluate', File|_] -> cli_evaluate(File)
    ; start
    ).

start :-
    ap_defaults:default_scenario(S),
    menu_loop(S).

menu_loop(Current) :-
    ap_ui:clear_screen,
    ap_ui:banner,
    format('Skenario aktif: ~w~n', [Current.name]),
    format('~n[1] Simulasi cepat (guided)~n', []),
    format('[2] Edit semua variabel (advanced)~n', []),
    format('[3] Jalankan skenario aktif~n', []),
    format('[4] Simulasikan 7 hari ke depan~n', []),
    format('[5] Bandingkan respons kebijakan~n', []),
    format('[6] Simpan skenario~n', []),
    format('[7] Muat skenario~n', []),
    format('[8] Lihat audit log lokal~n', []),
    format('[9] Metodologi / hukum / referensi~n', []),
    format('[10] Evaluasi model dari CSV historis~n', []),
    format('[11] Muat skenario contoh~n', []),
    format('[12] Export hasil aktif ke JSON~n', []),
    format('[0] Keluar~n~n', []),
    read_choice(Choice),
    dispatch(Choice, Current, Next, Continue),
    ( Continue == yes -> menu_loop(Next) ; true ).

read_choice(C) :-
    format('Pilih: '), flush_output,
    read_line_to_string(user_input, S0), normalize_space(string(S), S0),
    ( catch(number_string(C0, S), _, fail) -> C=C0 ; C = -1 ).

dispatch(1, S0, S, yes) :- !, guided(S0, S), run_and_pause(S).
dispatch(2, S0, S, yes) :- !, advanced(S0, S), run_and_pause(S).
dispatch(3, S, S, yes) :- !, run_and_pause(S).
dispatch(4, S, S, yes) :- !, timeline_screen(S), ap_ui:pause.
dispatch(5, S, S, yes) :- !, ap_compare:compare_responses(S, Rs), ap_report:print_comparison(Rs), ap_ui:pause.
dispatch(6, S, S, yes) :- !, save_screen(S), ap_ui:pause.
dispatch(7, S0, S, yes) :- !, load_screen(S0, S), ap_ui:pause.
dispatch(8, S, S, yes) :- !, ap_audit:show_audit, ap_ui:pause.
dispatch(9, S, S, yes) :- !, methodology_screen, ap_ui:pause.
dispatch(10, S, S, yes) :- !, evaluate_screen, ap_ui:pause.
dispatch(11, S0, S, yes) :- !, example_screen(S0, S), run_and_pause(S).
dispatch(12, S, S, yes) :- !, export_screen(S), ap_ui:pause.
dispatch(0, S, S, no) :- !, format('dadah. jangan lupa: kritik kebijakan ≠ kriminal. 💀~n', []).
dispatch(_, S, S, yes) :- format('Pilihan tidak dikenal.~n', []), ap_ui:pause.

run_and_pause(S) :-
    ap_model:score(S, R),
    ap_report:print_report(R),
    catch(ap_audit:record_report(R), E, print_message(warning, E)),
    ap_ui:pause.

guided(S0, S) :-
    ap_ui:prompt_string('Nama skenario', S0.name, Name),
    scope_options(ScopeOpts), ap_ui:prompt_choice('Skala isu', ScopeOpts, 2, Scope),
    issue_options(IssueOpts), ap_ui:prompt_choice('Jenis isu', IssueOpts, 5, Issue),
    target_options(TargetOpts), ap_ui:prompt_choice('Target tuntutan', TargetOpts, 1, Target),
    ap_ui:prompt_string('Sub-isu singkat', S0.subissue, Sub),
    ap_ui:prompt_string('Provinsi', S0.province, Province),
    ap_ui:prompt_string('Kota/lokasi umum (tanpa alamat pribadi)', S0.city, City),
    ap_ui:prompt_number('Akumulasi keluhan', 0,100,S0.grievance,Grievance),
    ap_ui:prompt_number('Kekuatan pemicu', 0,100,S0.trigger,Trigger),
    ap_ui:prompt_number('Kepentingan/salience isu',0,100,S0.salience,Salience),
    ap_ui:prompt_number('Dukungan publik pada tuntutan',0,100,S0.public_support,Support),
    ap_ui:prompt_number('Momentum daring',0,100,S0.online,Online),
    ap_ui:prompt_number('Responsivitas/dialog pemerintah',0,100,S0.govt_responsiveness,Resp),
    ap_ui:prompt_number('Kualitas bukti input',0,100,S0.evidence_quality,Q),
    put_dict(_{name:Name,scope:Scope,issue:Issue,target:Target,subissue:Sub,province:Province,city:City,
               grievance:Grievance,trigger:Trigger,salience:Salience,public_support:Support,online:Online,
               govt_responsiveness:Resp,evidence_quality:Q}, S0, S).

advanced(S0, S) :-
    guided(S0, G),
    advanced_pairs([
      coalition-'Kekuatan koalisi', organization-'Kapasitas organisasi',
      economic_stress-'Tekanan ekonomi', institutional_distrust-'Ketidakpercayaan institusional',
      incident_shock-'Insiden pemicu tambahan', recent_precedent-'Preseden aksi terbaru',
      media_attention-'Perhatian media', regional_relevance-'Relevansi lintas wilayah',
      govt_communication-'Kualitas komunikasi pemerintah', organizer_control-'Disiplin/kontrol penyelenggara',
      intervention_pressure-'Tekanan/intervensi terhadap aksi'
    ], G, S1),
    ap_ui:prompt_number('Durasi skenario (hari)',1,365,S1.duration_days,Days),
    ap_ui:prompt_number('Populasi area (juta)',0.01,300,S1.population_millions,Pop),
    ap_ui:prompt_number('Seed simulasi',1,2147483647,S1.seed,Seed),
    notify_options(NOpts), ap_ui:prompt_choice('Status pemberitahuan aksi', NOpts, 3, Notified),
    put_dict(_{duration_days:Days,population_millions:Pop,seed:Seed,notified:Notified}, S1, S).

advanced_pairs([], S, S).
advanced_pairs([Key-Label|Xs], S0, S) :-
    get_dict(Key, S0, Default),
    ap_ui:prompt_number(Label,0,100,Default,V),
    put_dict(Key, S0, V, S1),
    advanced_pairs(Xs, S1, S).

scope_options(Opts) :- findall(I-V-T, (ap_defaults:scope(I,V), atom_string(V,T)), Opts).
issue_options(Opts) :- findall(I-V-T, (ap_defaults:issue(I,V), atom_string(V,T)), Opts).
target_options(Opts) :- findall(I-V-T, (ap_defaults:target(I,V), atom_string(V,T)), Opts).
notify_options([1-yes-'Ya',2-no-'Tidak',3-unknown-'Tidak diketahui']).

timeline_screen(S) :-
    ap_simulation:timeline(S, 7, Reports, Events),
    format('~nTIMELINE 7 HARI (seed deterministik ~w)~n', [S.seed]),
    print_days(Reports, 0),
    format('~nEvent drift:~n', []), forall(member(E, Events), format(' - ~w~n',[E])).

print_days([], _).
print_days([R|Rs], Day) :-
    format('Hari +~w: likelihood ~w | spread ~w | escalation ~w | ~w~n',
           [Day,R.likelihood,R.spread,R.escalation,R.predicted_state]),
    D1 is Day+1, print_days(Rs,D1).

save_screen(S) :-
    ap_ui:prompt_string('Nama file', 'skenario', F),
    catch((ap_io:save_scenario(F,S), format('Tersimpan.~n',[])), E, print_message(error,E)).

load_screen(_S0, S) :-
    ap_ui:prompt_string('File skenario', 'skenario.ap.pl', F),
    catch(ap_io:load_scenario(F,S1), E, (print_message(error,E), fail)), !, S=S1.
load_screen(S, S).


example_screen(_S0, S) :-
    Options = [
      1-'scenario_bbm.ap.pl'-'BBM / tekanan ekonomi',
      2-'scenario_ukt.ap.pl'-'UKT / pendidikan',
      3-'scenario_integritas.ap.pl'-'Integritas / antikorupsi'
    ],
    ap_ui:prompt_choice('Pilih skenario contoh', Options, 1, Base),
    example_file(Base, File),
    catch(ap_io:load_scenario(File, S1), E, (print_message(error,E), fail)), !,
    S = S1.
example_screen(S, S).

example_file(Base, File) :-
    source_file(ap_cli:start, Here),
    file_directory_name(Here, PrologDir),
    file_directory_name(PrologDir, PackDir),
    directory_file_path(PackDir, examples, ExamplesDir),
    directory_file_path(ExamplesDir, Base, File).

export_screen(S) :-
    ap_model:score(S, R),
    ap_ui:prompt_string('Nama file JSON', 'hasil-antisipasipejabat', F),
    catch((ap_io:export_report_json(F, R), format('Hasil diekspor ke JSON.~n', [])),
          E, print_message(error,E)).

methodology_screen :-
    format('~nMETODOLOGI SINGKAT~n', []),
    format('- Model v0.1 = weighted explainable heuristic, belum diklaim terkalibrasi.~n', []),
    format('- Memisahkan likelihood, spread, escalation, pressure, confidence.~n', []),
    format('- Turnout memakai bucket, bukan jumlah presisi.~n', []),
    format('- Tidak ada profiling individu, daftar aktivis, rute, atau rekomendasi penindakan.~n', []),
    ap_legal:legal_summary,
    ap_reference:print_references.

evaluate_screen :-
    ap_ui:prompt_string('CSV historis', 'examples/historical_synthetic.csv', F),
    cli_evaluate(F).

cli_evaluate(File) :-
    catch((ap_calibration:evaluate_csv(File,S), ap_calibration:print_evaluation(S)), E, print_message(error,E)).

cli_simulate_file(File) :-
    catch((ap_io:load_scenario(File,S), ap_model:score(S,R), ap_report:print_report(R)), E, print_message(error,E)).

help :-
    format('Antisipasi Pejabat v0.1.0.0~n', []),
    format('  swipl antisipasipejabat              # menu interaktif~n', []),
    format('  swipl antisipasipejabat --help       # bantuan~n', []),
    format('  swipl antisipasipejabat --version    # versi~n', []),
    format('  swipl antisipasipejabat simulate FILE.ap.pl~n', []),
    format('  swipl antisipasipejabat evaluate FILE.csv~n', []).
