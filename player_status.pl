/* File : player_status.pl */
/* File to store player status */

/* Set dynamc predicates */
:- dynamic(pokemon_count/1).
:- dynamic(pokemon_slot/2).

/* Initialize pokemon count */
pokemon_count(0).

/* Initialize player's pokemon slot */
pokemon_slot(1, -1).
pokemon_slot(2, -1).
pokemon_slot(3, -1).
pokemon_slot(4, -1).
pokemon_slot(5, -1).
pokemon_slot(6, -1).

/* Procedure to add pokemon to inventory*/
add_pokemon(IdSlot, IdPoke) :- 
    pokemon_count(X), 
    Z is X+1,
    assertz(pokemon_slot(IdSlot, IdPoke)),
    assertz(pokemon_count(Z)),
    retract(pokemon_slot(IdSlot, -1)),
    retract(pokemon_count(X)),
    pokemon_count(Z).

/* Procedure to remove pokemon from inventory */
del_pokemon(IdSlot) :-
    pokemon_count(X),
    Z is X-1,
    retract(pokemon_slot(IdSlot, _)),
    retract(pokemon_count(X)),
    assertz(pokemon_slot(IdSlot, -1)),
    assertz(pokemon_count(Z)),
    pokemon_count(Z).


