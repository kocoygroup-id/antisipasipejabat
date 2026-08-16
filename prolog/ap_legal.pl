:- module(ap_legal, [legal_note/2, legal_summary/0]).

/** <module> Catatan hukum ringkas.

Bukan nasihat hukum. Rujukan utama ada di docs/REFERENSI.md.
*/

legal_note(S, Note) :-
    N = S.notified,
    ( N == yes ->
        Note = 'Pemberitahuan ditandai YA. Tetap cek UU 9/1998 dan aturan/putusan terbaru; tool ini bukan nasihat hukum.'
    ; N == no ->
        Note = 'Pemberitahuan ditandai TIDAK. Ketidakadaan pemberitahuan saja tidak boleh otomatis diperlakukan sebagai tindak pidana; lihat konstruksi kumulatif Pasal 256 KUHP dan Putusan MK 271/PUU-XXIII/2025. Tool ini bukan nasihat hukum.'
    ; Note = 'Status pemberitahuan tidak diketahui. Jangan menyimpulkan legal/ilegal hanya dari field ini; cek UU 9/1998, KUHP, dan putusan MK terbaru.'
    ).

legal_summary :-
    format('~nCATATAN HUKUM (bukan nasihat hukum)~n', []),
    format('- Kebebasan menyampaikan pendapat di muka umum diatur antara lain dalam UU 9/1998.~n', []),
    format('- Pasal 256 KUHP memuat unsur kumulatif; ketiadaan pemberitahuan semata bukan satu-satunya unsur.~n', []),
    format('- Selalu verifikasi peraturan dan putusan terbaru sebelum keputusan nyata.~n~n', []).
