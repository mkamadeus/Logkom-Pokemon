% map_object(X, Y, Obj) = Object Obj at position (X, Y)
map_object(1, 1, 'S').

map_size(10, 10).

% DRAW MAP BORDERS
% Right Border
draw_point(X, Y) :- map_size(W, H),
					X =:= W + 1,
					Y =< H + 1,
					write('X '), nl,
					NewY is Y+1,
					draw_point(0, NewY).
		
% Left Border		
draw_point(X, Y) :- map_size(W, H),
					X =:= 0,
					Y =< H+1,
					write('X '),
					NewX is X+1,
					draw_point(NewX, Y).
				
% Top Border				
draw_point(X, Y) :- map_size(W, H),
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
					(\+ map_object(X, Y, Obj)),
					write('- '),
					NewX is X+1,
					draw_point(NewX, Y).

draw_map :- draw_point(0, 0).