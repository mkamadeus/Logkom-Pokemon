:- dynamic(map_object/3).

% map_object(X, Y, Obj) = Object Obj at position (X, Y)
map_object(4, 3, 'X').
map_object(4, 4, 'X').
map_object(4, 5, 'X').
map_object(5, 8, 'X').
map_object(6, 8, 'X').
map_object(7, 8, 'X').
map_object(8, 4, 'G').

map_size(10, 10).

map :-
	game_start(true), !,
	draw_map.

map :- !,
	write('Game has not started, use \"start.\" to play the game"').

% DRAW MAP BORDERS
% Right Border
draw_point(X, Y) :- map_size(W, H),
					X =:= W + 1,
					Y =< H + 1,
					write('X '), nl,
					NewY is Y+1,
					draw_point(0, NewY).
		
% Left Border		
draw_point(X, Y) :- map_size(_, H),
					X =:= 0,
					Y =< H+1,
					write('X '),
					NewX is X+1,
					draw_point(NewX, Y).
				
% Top Border				
draw_point(X, Y) :- map_size(W, _),
					X < W + 1,
					X > 0,
					Y =:= 0,
					write('X '),
					NewX is X+1,
					draw_point(NewX, Y).
					
% Bottom Border				
draw_point(X, Y) :- map_size(W, H),
					X < W + 1,
					X > 0,
					Y =:= H + 1,
					write('X '),
					NewX is X+1,
					draw_point(NewX, Y).					

% DRAW MAP INSIDE
draw_point(X, Y) :- map_size(W, H),
					X < W + 1,
					X > 0,
					Y < H + 1,
					Y > 0,
					map_object(X, Y, 'P'),
					map_object(X, Y, 'G'), !,
					write('S'),
					write(' '),
					NewX is X+1,
					draw_point(NewX, Y).
					
% DRAW MAP INSIDE
draw_point(X, Y) :- map_size(W, H),
					X < W + 1,
					X > 0,
					Y < H + 1,
					Y > 0,
					map_object(X, Y, Obj), !,
					write(Obj),
					write(' '),
					NewX is X+1,
					draw_point(NewX, Y).

% Empty tile
draw_point(X, Y) :- map_size(W, H),
					X < W + 1,
					X > 0,
					Y < H + 1,
					Y > 0,
					(\+ map_object(X, Y, _)),
					write('- '),
					NewX is X+1,
					draw_point(NewX, Y).

draw_map :- draw_point(0, 0).