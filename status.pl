/* File : status.pl */
/* Store status command. */

status :- 
    game_start(true),
    print_all_slot.