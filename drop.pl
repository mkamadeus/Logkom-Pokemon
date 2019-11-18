/* File : drop.pl */
/* drop pokemon program */

% Kasus pertama -> Normal
drop(X):-
	(\+ in_battle),
	pokemon_inventory(_, CountInv),
	CountInv>1,
	pokemon_exists(1, X, PokeId),!,
	delete_pokemon(PokeId),
	write('Success, You dropped '), write(X).

% Fail condition : Dalam Battle
drop(_):-
	in_battle,!,
	write('You can\'t drop right now, you are in a battle, Focus...!').

% Fail condition : Pokemon tidak ada di Inventory
drop(X):-
	(\+ pokemon_exists(1, X, _)),!,
	write('You don\'t have that Pokemon, type \'status\' to check your inventory.').

% Fail condition : Inventory Hanya 1
drop(_):-
	pokemon_inventory(_, CountInv),
	CountInv =<1,!,
	write('You can\'t drop it. You only have a pokemon Broo, Are you kidding...?').
