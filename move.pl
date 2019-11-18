/*File berisikan move dari popomon*/
/*Versi 11 november 2019 */
/*Kelompok 12*/
:- include('map.pl').

n:-       /*Bergerak ke Utara (atas)*/
	game_start(true),
    map_object(X,Y,'P'),
    YNew is Y-1,
    (\+ map_object(X, YNew, 'X')),
    map_size(W, H),
    YNew > 0, YNew =< H, !,
    retract(map_object(X, Y, 'P')),
    assertz(map_object(X,YNew,'P')).

n :-
    game_start(false), !,
	write('Game has not started, use \"start.\" to play the game"').

n :-
    hit_wall.

e:- /*Bergerak ke timur (kanan)*/
	game_start(true),
    map_object(X,Y,'P'),
    XNew is X+1,
    (\+ map_object(XNew, Y, 'X')),
    map_size(W, H),
    XNew > 0, XNew =< W, !,
    retract(map_object(X, Y, 'P')),
    assertz(map_object(XNew,Y,'P')).

e :-
    game_start(false), !,
	write('Game has not started, use \"start.\" to play the game"').

e :-
    hit_wall.

s:- /*Bergerak ke Selatan (bawah)*/
	game_start(true),
    map_object(X,Y,'P'),
    YNew is Y+1,
    (\+ map_object(X, YNew, 'X')),
    map_size(W, H),
    YNew > 0, YNew =< H, !,
    retract(map_object(X, Y, 'P')),
    assertz(map_object(X,YNew,'P')).

s :-
    game_start(false), !,
	write('Game has not started, use \"start.\" to play the game"').

s :-
    hit_wall.

w:- /*Bergerak ke barat(kiri)*/
	game_start(true),
    map_object(X,Y,'P'),
    XNew is X-1,
    (\+ map_object(XNew, Y, 'X')),
    map_size(W, H),
    XNew > 0, XNew =< W, !,
    retract(map_object(X, Y, 'P')),
    assertz(map_object(XNew,Y,'P')).

w :-
    game_start(false), !,
	write('Game has not started, use \"start.\" to play the game"').
    
w :-
    hit_wall.

hit_wall :-
    write('You hit a wall, try using \'map.\' to see where you are right now').