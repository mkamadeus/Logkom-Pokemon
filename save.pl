/* File : save.pl */
/* File for storing save file mechanism */

save :-
    open('savefile.dat',write,S),
    set_output(S),
    listing,
    close(S).