/* File : player_status.pl */
/* File to store player status */

:- include('pokemon.pl').

/* Set dynamc predicates */
:- dynamic(pokemon_count/1).
:- dynamic(pokemon_slot/2).
:- dynamic(pokemon_health/2).

/* Initialize pokemon count */
pokemon_count(0).

/* Initialize player's pokemon slot */
pokemon_slot(1, -1).
pokemon_slot(2, -1).
pokemon_slot(3, -1).
pokemon_slot(4, -1).
pokemon_slot(5, -1).
pokemon_slot(6, -1).

pokemon_health(1, 0).
pokemon_health(2, 0).
pokemon_health(3, 0).
pokemon_health(4, 0).
pokemon_health(5, 0).
pokemon_health(6, 0).

/* Procedure to add pokemon to inventory*/
add_pokemon(IdSlot, IdPoke) :- 
    pokemon_count(X), 
    Z is X+1,
    health(IdPoke, Health),
    assertz(pokemon_slot(IdSlot, IdPoke)),
    assertz(pokemon_count(Z)),
    assertz(pokemon_health(IdSlot, Health)),
    retract(pokemon_slot(IdSlot, -1)),
    retract(pokemon_count(X)),
    retract(pokemon_health(IdSlot, 0)),
    pokemon_count(Z).

/* Procedure to remove pokemon from inventory */
del_pokemon(IdSlot) :-
    pokemon_count(X),
    Z is X-1,
    retract(pokemon_slot(IdSlot, _)),
    retract(pokemon_count(X)),
    retract(pokemon_health(IdSlot, _)),
    assertz(pokemon_slot(IdSlot, -1)),
    assertz(pokemon_count(Z)),
    assertz(pokemon_health(IdSlot, 0)),
    pokemon_count(Z).


