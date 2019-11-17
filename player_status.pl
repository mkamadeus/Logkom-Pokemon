/* File : player_status.pl */
/* File to store player status */

/* Set dynamc predicates */
:- dynamic(pokemon_inventory/2).

/* Pokemon slot */
pokemon_inventory([],0).

/* Initialize player's pokemon slot */

/* Utility function for inserting pokemon at end of list */
insert_back(X, [], [X]).
insert_back(X, [H|Tail1], [H|Tail2]):-insert_back(X,Tail1, Tail2).

/* Utility function for deleting nth pokemon of the list */
delete_nth(1, [_|T], T).
delete_nth(N, [H|Tail1], [H|Tail2]) :- N1 is N-1, delete_nth(N1, Tail1, Tail2).

/* Procedure to add pokemon to inventory*/
insert_pokemon(PokeId) :- 
    pokemon_inventory(PokeList,PokeCount),
    NewPokeCount is PokeCount+1,
    insert_back(PokeId, PokeList, NewPokeList),
    assertz(pokemon_inventory(NewPokeList, NewPokeCount)),
    retract(pokemon_inventory(PokeList, PokeCount)).

/* Procedure to remove pokemon from inventory */
delete_pokemon(SlotId) :-
    pokemon_inventory(PokeList,PokeCount),
    NewPokeCount is PokeCount-1,
    delete_nth(SlotId, PokeList, NewPokeList),
    assertz(pokemon_inventory(NewPokeList, NewPokeCount)),
    retract(pokemon_inventory(PokeList, PokeCount)).

