:- dynamic(legendary/1).

check_win :-
    (\+ legendary(_)), !,
    retract(game_start(true)),
    asserta(game_start(false)),
    write('You have successfully defeated all legendary pokemons. You have won! Type \'start.\' to play again').

check_win :- !.

remove_legendary(PokeId) :-
    legendary(PokeId), !,
    retract(legendary(PokeId)),
    check_win.
    
remove_legendary(_) :- !.