%:- include('battle.pl').
%:- include('player.pl').

capture :-
    game_start(true),
    (\+ in_battle),
    enemy_pokemon(PokeId),
    PokeId =\= 0,
    pokemon_inventory(_, Count),
    Count < 6, !,
    insert_pokemon(PokeId),
    retract(enemy_pokemon(_)),
    assertz(enemy_pokemon(0)),
    poke_name(PokeId, Name),
    write(Name), write(' is captured!').

capture :-
    game_start(false), !,
	write('Game has not started, use \"start.\" to play the game"').

capture :-
    in_battle, !,
    write('You are in a battle. Use \'help.\' to display all commands available in a battle!').

capture :-
    enemy_pokemon(0), !,
    write('There are no Pokemons to be captured.').
    
capture :- !,
    write('Your inventory is full! You have to drop a Pokemon first.').
    
skip_capture :- !,
    retract(enemy_pokemon(_)),
    assertz(enemy_pokemon(0)).
