/* File : heal.pl */
/* File for the heal command */

:- include('player.pl')

heal :- 
    map_object(X,Y, 'P'),
    map_object(X,Y, 'G'),
    pokemon_inventory(PokeList, _),

    heal_nth_slot(1),
    nth_item(PokeList,1,PokeId1),
    poke_name(PokeId1, PokeName1),
    write(PokeName1),
    write(" healed.\n"),

    heal_nth_slot(2),
    nth_item(PokeList,2,PokeId2),
    poke_name(PokeId2, PokeName2),
    write(PokeName2),
    write(" healed.\n"),
    
    heal_nth_slot(3),
    nth_item(PokeList,3,PokeId3),
    poke_name(PokeId3, PokeName3),
    write(PokeName3),
    write(" healed.\n"),

    heal_nth_slot(4),
    nth_item(PokeList,4,PokeId4),
    poke_name(PokeId4, PokeName4),
    write(PokeName4),
    write(" healed.\n"),

    heal_nth_slot(5),
    nth_item(PokeList,5,PokeId5),
    poke_name(PokeId5, PokeName5),
    write(PokeName5),
    write(" healed.\n"),
    
    heal_nth_slot(6),
    nth_item(PokeList,6,PokeId6),
    poke_name(PokeId6, PokeName6),
    write(PokeName6),
    write(" healed.\n").

heal_nth_slot(N) :-
    pokemon_inventory(PokeList, _),
    pokemon_health(PokeHealthList),

    nth_item(PokeList, N, NthId),
    health(NthId, NthHealth),
    set_nth_item(PokeHealthList, N, NthHealth, NewPokeHealthList),

    retract(pokemon_health(PokeHealthList)),
    assertz(pokemon_health(NewPokeHealthList)).


