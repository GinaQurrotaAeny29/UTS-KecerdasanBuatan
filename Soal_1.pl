% File: UTS.pl

:- dynamic daun_menguning/0, bercak_hitam/0, daun_berlubang/0, tanaman_layu/0, no/1.

% Aturan Diagnosa
diagnosa('Kutu Daun') :-
    daun_menguning,
    \+ bercak_hitam,
    \+ daun_berlubang,
    \+ tanaman_layu.

diagnosa('Jamur Patogen') :-
    bercak_hitam,
    \+ daun_menguning,
    \+ daun_berlubang,
    \+ tanaman_layu.

diagnosa('Ulat Daun') :-
    daun_berlubang,
    \+ daun_menguning,
    \+ bercak_hitam,
    \+ tanaman_layu.

diagnosa('Nematoda Tanah') :-
    tanaman_layu,
    \+ daun_menguning,
    \+ bercak_hitam,
    \+ daun_berlubang.

diagnosa('Tanaman Sehat') :-
    no(daun_menguning),
    no(bercak_hitam),
    no(daun_berlubang),
    no(tanaman_layu).

% Tanya gejala
tanya(Gejala) :-
    format('Apakah ~w? (ya/tidak): ', [Gejala]),
    read(Jawaban),
    (Jawaban == ya -> assertz(Gejala) ; assertz(no(Gejala))).

% Program Utama
mulai :-
    % Reset fakta lama
    retractall(daun_menguning),
    retractall(bercak_hitam),
    retractall(daun_berlubang),
    retractall(tanaman_layu),
    retractall(no(_)),
    % Tanya user
    tanya(daun_menguning),
    tanya(bercak_hitam),
    tanya(daun_berlubang),
    tanya(tanaman_layu),
    nl, write('--- Hasil Identifikasi ---'), nl,
    (
        diagnosa(Hama) ->
            format('Diagnosa: ~w.~n', [Hama])
    ;
        write('Maaf, gejala tidak sesuai dengan hama yang diketahui.')
    ).

