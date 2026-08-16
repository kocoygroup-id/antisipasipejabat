:- module(ap_ui,
          [ banner/0,
            pause/0,
            prompt_string/3,
            prompt_number/5,
            prompt_choice/4,
            clear_screen/0
          ]).

:- use_module(library(readutil)).

banner :-
    format('~n', []),
    format('  █████  ANTISIPASI PEJABAT  █████~n', []),
    format('  Indonesian Civil Demonstration Risk Simulator~n', []),
    format('  v0.1.0.0  |  full SWI-Prolog  |  terminal~n', []),
    format('  "sebelum tiket makin bengkak" edition 💀~n', []),
    format('------------------------------------------------------------~n', []),
    format('Simulasi agregat. Bukan alat pengawasan individu / represi.~n~n', []).

pause :-
    format('~nTekan ENTER untuk lanjut...', []), flush_output,
    read_line_to_string(user_input, _).

prompt_string(Label, Default, Value) :-
    format('~w [~w]: ', [Label, Default]), flush_output,
    read_line_to_string(user_input, S0),
    normalize_space(string(S), S0),
    ( S == "" -> Value = Default ; Value = S ).

prompt_number(Label, Min, Max, Default, Value) :-
    repeat,
      format('~w (~w-~w) [~w]: ', [Label, Min, Max, Default]), flush_output,
      read_line_to_string(user_input, S0), normalize_space(string(S), S0),
      ( S == "" -> Value = Default, !
      ; catch(number_string(N, S), _, fail), N >= Min, N =< Max -> Value=N, !
      ; format('Input harus angka ~w sampai ~w.~n', [Min, Max]), fail
      ).

prompt_choice(Label, Options, DefaultIndex, Value) :-
    format('~n~w~n', [Label]),
    forall(member(I-_V-Text, Options), format('  [~w] ~w~n', [I, Text])),
    repeat,
      format('Pilih [~w]: ', [DefaultIndex]), flush_output,
      read_line_to_string(user_input, S0), normalize_space(string(S), S0),
      ( S == "" -> I=DefaultIndex
      ; catch(number_string(I, S), _, fail)
      ),
      ( memberchk(I-Value-_, Options) -> ! ; format('Pilihan tidak valid.~n', []), fail ).

clear_screen :-
    ( current_prolog_flag(windows, true) -> shell('cls') ; shell('clear') ), !.
clear_screen.
