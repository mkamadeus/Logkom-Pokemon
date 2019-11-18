:- dynamic(legendary/1).

remove_legendary(PokeId) :-
    legendary(PokeId), !,
    retract(legendary(PokeId)).
    
remove_legendary(_) :- !.