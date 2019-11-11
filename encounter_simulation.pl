/* File : encounter_simulation.pl */
/* Place to store Pokemon Facts */

:- include('./pokemon.pl').

pizza(Id, Pokemon):-poke_name(Id, Z), Pokemon is Z.

encounter_pokemon(Pokemon):-random(0,101,X),encounter_weight(Y,Z),X=<Z,Pokemon is Y.
encounter(Chance, Result):-random(0,101,X), X =< Chance, encounter_pokemon(P), Result is P.