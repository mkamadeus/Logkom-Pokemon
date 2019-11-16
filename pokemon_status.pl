/* File : pokemon_status.pl */
/* File to store pokemon status */

:- include('pokemon.pl').
:- include('player_status.pl').

print_pokemon_status(IdSlot):-
    pokemon_slot(IdSlot, IdPoke),
    IdPoke \= -1,
    poke_name(IdPoke, NamePoke),
    write(NamePoke),
    write("\n"),
    pokemon_health(IdPoke, HealthPoke),
    write("Health : "),
    write(HealthPoke),
    write("\n"),
    attack(IdPoke, AttackPoke),
    write("Attack : "),
    write(AttackPoke),
    write("\n"),
    type(IdPoke, TypePoke),
    write("Type : "),
    write(TypePoke),
    write("\n"),
    write("\n").

print_inventory :-
    write("Your Pokemon:\n"),
    print_pokemon_status(1),
    print_pokemon_status(2),
    print_pokemon_status(3),
    print_pokemon_status(4),
    print_pokemon_status(5),
    print_pokemon_status(6).