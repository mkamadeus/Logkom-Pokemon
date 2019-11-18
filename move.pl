/*File berisikan move dari popomon*/
/*Versi 11 november 2019 */
/*Kelompok 12*/

hit_wall :-
    write('You hit a wall, try using \'map.\' to see where you are right now').

encounter :-
    encounter_pokemon(11, X), !,
    retract(enemy_pokemon(_)),
    assertz(enemy_pokemon(X)),
    health(X, Health),
    retract(enemy_health(_)),
    assertz(enemy_health(Health)),
    init_battle.

encounter :- !.

/*Bergerak ke Utara (atas)*/
n:-       
	game_start(true),
    (\+ in_battle),
    map_object(X,Y,'P'),
    YNew is Y-1,
    (\+ map_object(X, YNew, 'X')),
    map_size(_, H),
    YNew > 0, YNew =< H, !,
    retract(map_object(X, Y, 'P')),
    assertz(map_object(X,YNew,'P')),
    skip_capture,
    encounter.

n :-
    game_start(false), !,
	write('Game has not started, use \"start.\" to play the game"').

n :-
    in_battle, !,
    write('You are in a battle. Use \'help.\' to display all commands available in a battle!').

n :-
    hit_wall.

/*Bergerak ke timur (kanan)*/
e:- 
	game_start(true),
    (\+ in_battle),
    map_object(X,Y,'P'),
    XNew is X+1,
    (\+ map_object(XNew, Y, 'X')),
    map_size(W, _),
    XNew > 0, XNew =< W, !,
    retract(map_object(X, Y, 'P')),
    assertz(map_object(XNew,Y,'P')),
    skip_capture,
    encounter.

e :-
    game_start(false), !,
	write('Game has not started, use \"start.\" to play the game"').

e :-
    in_battle, !,
    write('You are in a battle. Use \'help.\' to display all commands available in a battle!').

e :-
    hit_wall.

/*Bergerak ke Selatan (bawah)*/
s:- 
	game_start(true),
    (\+ in_battle),
    map_object(X,Y,'P'),
    YNew is Y+1,
    (\+ map_object(X, YNew, 'X')),
    map_size(_, H),
    YNew > 0, YNew =< H, !,
    retract(map_object(X, Y, 'P')),
    assertz(map_object(X,YNew,'P')),
    skip_capture,
    encounter.

s :-
    game_start(false), !,
	write('Game has not started, use \"start.\" to play the game"').

s :-
    in_battle, !,
    write('You are in a battle. Use \'help.\' to display all commands available in a battle!').

s :-
    hit_wall.

/*Bergerak ke barat(kiri)*/
w:- 
	game_start(true),
    (\+ in_battle),
    map_object(X,Y,'P'),
    XNew is X-1,
    (\+ map_object(XNew, Y, 'X')),
    map_size(W, _),
    XNew > 0, XNew =< W, !,
    retract(map_object(X, Y, 'P')),
    assertz(map_object(XNew,Y,'P')),
    skip_capture,
    encounter.

w :-
    game_start(false), !,
	write('Game has not started, use \"start.\" to play the game"').
    
w :-
    in_battle, !,
    write('You are in a battle. Use \'help.\' to display all commands available in a battle!').

w :-
    hit_wall.