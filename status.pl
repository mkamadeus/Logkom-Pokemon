/* File : status.pl */
/* Store status command. */

status :- 
    game_start(true), !,
    print_all_slot.

status :-
    game_start(false), !,
	write('Game has not started, use \"start.\" to play the game"').
