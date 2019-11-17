/* File : help.pl */
/* Store help command */

help:-
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