/* File : encounter_simulation.pl */
/* Place to store Pokemon Facts */

:- include('pokemon.pl').

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
