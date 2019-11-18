/*File berisikan move dari popomon*/
/*Versi 11 november 2019 */
/*Kelompok 12*/
:- include('map.pl').
:- include('battle.pl').
:- include('pokemon.pl').
:- include('encounter_simulation').

hit_wall :-
    write('You hit a wall, try using \'map.\' to see where you are right now').

encounter :-
    encounter_pokemon(11, X), !,
    retract(enemy_pokemon(Any1)),
    assertz(enemy_pokemon(X)),
    health(X, Health),
    retract(enemy_health(Any2)),
    assertz(enemy_health(Health)),
    init_battle.

encounter :- !.

n:-       /*Bergerak ke Utara (atas)*/
	game_start(true),
    (\+ in_battle),
    map_object(X,Y,'P'),
    YNew is Y-1,
    (\+ map_object(X, YNew, 'X')),
    map_size(W, H),
    YNew > 0, YNew =< H, !,
    retract(map_object(X, Y, 'P')),
    assertz(map_object(X,YNew,'P')),
    encounter.

n :-
    game_start(false), !,
	write('Game has not started, use \"start.\" to play the game"').

n :-
    in_battle, !,
    write('You are in a battle. Use \'help.\' to display all commands available in a battle!').

n :-
    hit_wall.

e:- /*Bergerak ke timur (kanan)*/
	game_start(true),
    (\+ in_battle),
    map_object(X,Y,'P'),
    XNew is X+1,
    (\+ map_object(XNew, Y, 'X')),
    map_size(W, H),
    XNew > 0, XNew =< W, !,
    retract(map_object(X, Y, 'P')),
    assertz(map_object(XNew,Y,'P')),
    encounter.

e :-
    game_start(false), !,
	write('Game has not started, use \"start.\" to play the game"').

e :-
    in_battle, !,
    write('You are in a battle. Use \'help.\' to display all commands available in a battle!').

e :-
    hit_wall.

s:- /*Bergerak ke Selatan (bawah)*/
	game_start(true),
    (\+ in_battle),
    map_object(X,Y,'P'),
    YNew is Y+1,
    (\+ map_object(X, YNew, 'X')),
    map_size(W, H),
    YNew > 0, YNew =< H, !,
    retract(map_object(X, Y, 'P')),
    assertz(map_object(X,YNew,'P')),
    encounter.

s :-
    game_start(false), !,
	write('Game has not started, use \"start.\" to play the game"').

s :-
    in_battle, !,
    write('You are in a battle. Use \'help.\' to display all commands available in a battle!').

s :-
    hit_wall.

w:- /*Bergerak ke barat(kiri)*/
	game_start(true),
    (\+ in_battle),
    map_object(X,Y,'P'),
    XNew is X-1,
    (\+ map_object(XNew, Y, 'X')),
    map_size(W, H),
    XNew > 0, XNew =< W, !,
    retract(map_object(X, Y, 'P')),
    assertz(map_object(XNew,Y,'P')),
    encounter.

w :-
    game_start(false), !,
	write('Game has not started, use \"start.\" to play the game"').
    
w :-
    in_battle, !,
    write('You are in a battle. Use \'help.\' to display all commands available in a battle!').

w :-
    hit_wall.