/* File : encounter_simulation.pl */
/* Place to store Pokemon Facts */

:- include('pokemon.pl').

/* Encounter pokemon Simulation */
/* Process : Generates three random numbers, check if encounter possible. the Pokemon that will be encountered and a random weight value*/
/*           If the random weight value is smaller than the weight, the pokemon will be encountered. */

encounter_pokemon(IdLimit,Pokemon):-
    random(0,101,IsEncounter),
    IsEncounter =< 50,
    random(0,101,EncounterWeight),
    random(1,IdLimit,EncounterId),
    encounter_weight(EncounterId,EncounterRate),
    Pokemon is EncounterId,
    EncounterWeight=<EncounterRate,
    write("You encountered a "),
    poke_name(EncounterId, EncounterName),
    write(EncounterName),
    write("!\n").

