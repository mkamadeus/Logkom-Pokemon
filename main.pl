/* File : main.pl */
/* Main driver program */

:- include('map.pl').
:- include('pokemon_status.pl').

:- dynamic(game_start/1).

game_start(false).

start:-
    asserta(game_start(true)),
    retract(game_start(false)),
    write('___OooOOo.                                          ___'),nl,
    write('___O     `O                                         ___'),nl,
    write('___o      O                                         ___'),nl,
    write('___O     .o                                         ___'),nl,
    write('___oOooOO   .oOo. .oOo. .oOo. `oOOoOO. .oOo.  OoOo. ___'),nl,
    write('___o        O   o O   o O   o  O  o  o O   o  o   O ___'),nl,
    write('___O        o   O o   O o   O  o  O  O o   O  O   o ___'),nl,
    write('___o         OoO  oOoO   OoO   O  o  o  OoO   o   O ___'),nl,
    write('___               O                                 ___'),nl,
    write('___               o                                 ___'),nl,
    write('___o           O               o      o oO oO oO    ___'),nl,
    write('___O           o              O      O  OO OO OO    ___'),nl,
    write('___o           O              o      o  oO oO oO    ___'),nl,
    write('___O           O              O      o  Oo Oo Oo    ___'),nl,
    write('___o     o     o .oOo. `OoOo. o  .oOoO  oO oO oO    ___'),nl,
    write('___O     O     O O   o  o     O  o   O              ___'),nl,
    write('___ o   O o   O  o   O  O     o  O   o  Oo Oo Oo    ___'),nl,
    write('___  OoO   OoO    OoO   o     Oo  OoO o oO oO oO    ___'),nl,
    write('                                                    ___'),nl,
    write('                                                    ___'),nl,
    write('                                                    ___'),nl,
    write('Hello! Welcome to the world of Popomon!'),nl,
    write('My name is Doraemon! People call me Popomon expert!'),nl,
    write('There is a lot of Popomon loose in this world!'),nl,
    write('You need to catch them, to make this world more secure!'),nl,
    write('If you succeed, you will get stronger and you can control them!'),nl,
    write('But there are legendary Popomons! Tuan Yon and Professor Oak!'),nl,
    write('If you can catch all the legendary popomon, You win!'),nl,
    write('                                                   '),nl.

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

quit :- 
    game_start(true),
    write('Progress will not be saved after you quit.'),nl,
    write('Are you sure? (y/n): '),
    read(Param),
    (Param = y -> halt;
    (Param = n -> fail)).

status :- print_inventory.


map :- draw_map.