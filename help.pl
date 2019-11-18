/* File : help.pl */
/* Store help command */

help:-
    game_start(true),
    (\+ in_battle),
    write('                                                    '),nl,
    write('                                                    '),nl,
    write('Available commands:'),nl,
    write('     start. -- start the game!'),nl,
    write('     help. -- show available commands '),nl,
    write('     quit. -- quit the game'),nl,
    write('     n. s. e. w. -- move'),nl,
    write('     map. -- look at the map'),nl,
    write('     heal -- cure Tokemon in inventory if in gym center '),nl,
    write('     status. -- show your status '),nl,
    write('     save(Filename). -- save your game'),nl,
    write('     load(Filename). -- load previously saved game'),nl,
    write('                                                    '),nl,
    write('                                                    '),nl,
    write('Legends: '),nl,
    write('     - X = Pagar '),nl,
    write('     - P = Player '),nl,
    write('     - G = Gym '),nl.

help:-
    game_start(false), !,
	write('Game has not started, use \"start.\" to play the game"').

help:-
    in_battle, !,
    write('You are in a battle. This is command you can use now: '),nl,
    write('     fight.                      -- choose to fight the wild Pokemon that appears!'),nl,
    write('     run.                        -- choose to run from the wild Pokemon!'),nl,
    write('     pick("Pokemon\'s name").     -- choose the Pokemon you want to use!'),nl,
    write('     Attack.                     -- Normal attack! '),nl,
    write('     specialAttack.              -- Special attack!'),nl.