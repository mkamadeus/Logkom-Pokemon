/* File : encounter_simulation.pl */
/* Place to store Pokemon Facts */

:- include('pokemon.pl').

/* Encounter pokemon Simulation */
/* Process : Generates two random numbers, the Pokemon that will be encountered and a random weight value*/
/*           If the random weight value is smaller than the weight, the pokemon will be encountered. */

encounter_pokemon(IdLimit,Pokemon):-
    random(0,101,EncounterWeight),
    random(1,IdLimit,EncounterId),
    encounter_weight(EncounterId,EncounterRate),
    Pokemon is EncounterId,
    EncounterWeight=<EncounterRate,
    write("You encountered a/an "),
    poke_name(EncounterId, EncounterName),
    write(EncounterName),
    write("!\n").
