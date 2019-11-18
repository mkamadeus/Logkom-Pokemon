/* File : start.pl */
/* File for starting and initializing the game. */

:- dynamic(game_start/1).

game_start(false).

start:-
    ['pokemon.pl'],
    ['move.pl'],
    ['player.pl'],
    ['map.pl'],
    ['battle.pl'],
    ['encounter_simulation.pl'],
    ['capture.pl'],
    ['status.pl'],
    ['help.pl'],

    retract(game_start(false)), !,
    asserta(game_start(true)),
    write(' .sSSSSs.                                                                                      '),nl,
    write(' SSSSSSSSSs. .sSSSSs.    .sSSS  SSSSS  .sSSSSs.    .sSSSsSS SSsSSSSS .sSSSSs.    .sSSSs.  SSSSS'),nl, 
    write(' S SSS SSSSS S SSSSSSSs. S SSS SSSSS   S SSSSSSSs. S SSS  SSS  SSSSS S SSSSSSSs. S SSS SS SSSSS'),nl, 
    write(' S  SS SSSSS S  SS SSSSS S  SS SSSSS   S  SS SSSS  S  SS   S   SSSSS S  SS SSSSS S  SS  `sSSSSS'),nl, 
    write(' S..SS SSSSS S..SS SSSSS S..SSsSSSSS   S..SS       S..SS       SSSSS S..SS SSSSS S..SS    SSSSS'),nl, 
    write(' S:::SsSSSSS S:::S SSSSS S:::S SSSSS   S:::SSSS    S:::S       SSSSS S:::S SSSSS S:::S    SSSSS'),nl, 
    write(' S;;;S       S;;;S SSSSS S;;;S  SSSSS  S;;;S       S;;;S       SSSSS S;;;S SSSSS S;;;S    SSSSS'),nl, 
    write(' S%%%S       S%%%S SSSSS S%%%S  SSSSS  S%%%S SSSSS S%%%S       SSSSS S%%%S SSSSS S%%%S    SSSSS'),nl, 
    write(' SSSSS       SSSSSsSSSSS SSSSS   SSSSS SSSSSsSS;:  SSSSS       SSSSS SSSSSsSSSSS SSSSS    SSSSS'),nl, 
    write('                                                                                               '),nl,  
    write(' .sSSS       s.                                                                                '),nl, 
    write(' SSSSS       SSSs. .sSSSSs.    .sSSSSSSSs. SSSSS       .sSSSSs.                                '),nl, 
    write(' S SSS       SSSSS S SSSSSSSs. S SSS SSSSS S SSS       S SSSSSSSs.                             '),nl, 
    write(' S  SS       SSSSS S  SS SSSSS S  SS SSSS  S  SS       S  SS SSSSS                             '),nl, 
    write(' S..SS       SSSSS S..SS SSSSS S..SSsSSSa. S..SS       S..SS SSSSS                             '),nl, 
    write(' S:::S       SSSSS S:::S SSSSS S:::S SSSSS S:::S       S:::S SSSSS                             '),nl, 
    write(' S;;;S   S   SSSSS S;;;S SSSSS S;;;S SSSSS S;;;S       S;;;S SSSSS                             '),nl, 
    write(' S%%%S  SSS  SSSSS S%%%S SSSSS S%%%S SSSSS S%%%S SSSSS S%%%S SSSS                              '),nl, 
    write(' SSSSSsSS SSsSSSSS SSSSSsSSSSS SSSSS SSSSS SSSSSsSS;:  SSSSSsS;:                               '),nl,nl,



    write('Hello! Welcome to the world of Pokemon!'),nl,
    write('My name is Doraemon! People call me Pokemon expert!'),nl,
    write('There are a lot of Pokemons being loose in this world!'),nl,
    write('You need to catch them, to make this world more secure!'),nl,
    write('If you succeed, you will get stronger and you can control them!'),nl,
    write('But there are legendary Pokemons; Tuan Yon and Professor Oak!'),nl,
    write('If you can catch all the legendary Pokemons, you\'ll win!'),nl,
    write('                                                   '),nl,

    /* Pokemon slot */
    assertz(pokemon_inventory([],0)),
    assertz(pokemon_health([])),
    
    insert_pokemon(0), !,

    % Inisialisasi legendary
    assertz(legendary(10)),
    assertz(legendary(11)),

    % Inisialisasi selected_pokemon
    assertz(selected_pokemon(0)),
    assertz(enemy_pokemon(0)),
    assertz(enemy_health(0)),
    
    % Inisialisasi Player
    assertz(map_object(1, 1, 'P')).

start :-
    write('The game has already been started. Use \'help.\' to look at available commands!').

quit :- 
    game_start(true),
    write('Progress will not be saved after you quit.'),nl,
    write('Are you sure? (y/n): '),
    read(Param),
    (Param = y -> halt;
    (Param = n -> fail)).
