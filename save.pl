/* File : save.pl */
/* File for storing save file mechanism */

save :-
    write('Saving to savefile.dat...\n'),
    nl,
    open('savefile.dat',write,S),
    set_output(S),
    listing,
    close(S),
    write('Savefile successful!'),
    nl.