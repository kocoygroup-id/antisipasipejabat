:- module(ap_reference, [print_references/0]).

print_references :-
    format('~nReferensi inti:~n', []),
    format('1. ACLED Codebook - klasifikasi protest/riot.~n', []),
    format('2. ACLED Crowd Size Methodology (2026).~n', []),
    format('3. UU RI No. 9 Tahun 1998.~n', []),
    format('4. Putusan MK No. 271/PUU-XXIII/2025 (2026).~n', []),
    format('5. BPS WebAPI dan data.go.id.~n', []),
    format('6. Literatur forecasting social unrest (IMF, EMBERS, multi-source forecasting).~n', []),
    format('Lihat docs/REFERENSI.md untuk URL dan catatan penggunaan.~n~n', []).
