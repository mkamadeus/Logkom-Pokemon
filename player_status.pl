/* File : player_status.pl */
/* File to store player status */

:- dynamic(pokemon_count/1).
:- dynamic(pokemon_inventory/1).

pokemon_count(1).

pokemon_inventory(1).

add_pokemon(IdPoke) :- 
    pokemon_count(X), 
    Z is X+1, 
    assertz(pokemon_count(Z)), 
    retract(pokemon_count(X)),
    assertz(pokemon_inventory(IdPoke)), 
    pokemon_count(Z).

del_pokemon(IdPoke) :- 
    pokemon_count(X), 
    Z is X-1, 
    assertz(pokemon_count(Z)), 
    retract(pokemon_count(X)), 
    retract(pokemon_inventory(IdPoke)), 
    pokemon_count(Z).


