% Untuk memulai battle, run init_battle
% Command yang dibuka untuk player ada pada prosedur yang bersangkutan

:- include('pokemon.pl').
:- include('player.pl').

% selected_pokemon(IdSlot)
:- dynamic(selected_pokemon/1).

:- dynamic(enemy_pokemon/1).

:- dynamic(enemy_health/1).

:- dynamic(fight_or_flight/0).

% Ada bila player sedang battle
:- dynamic(in_battle/0).

:- dynamic(special_used/0).

% Inisialisasi selected_pokemon
selected_pokemon(0).
enemy_pokemon(0).
enemy_health(0).

% attack_multiplier(AttackType, DefendType, Multiplier)
attack_multiplier(normal, normal, 1).
attack_multiplier(normal, fire, 1).
attack_multiplier(normal, water, 1).
attack_multiplier(normal, grass, 1).
attack_multiplier(fire, normal, 1).
attack_multiplier(fire, fire, 1).
attack_multiplier(fire, water, 0.5).
attack_multiplier(fire, grass, 1.5).
attack_multiplier(water, normal, 1).
attack_multiplier(water, fire, 1.5).
attack_multiplier(water, water, 1).
attack_multiplier(water, grass, 0.5).
attack_multiplier(grass, normal, 1).
attack_multiplier(grass, fire, 0.5).
attack_multiplier(grass, water, 1.5).
attack_multiplier(grass, grass, 1).

% Melakukan inisialisasi battle
init_battle :-
    assertz(fight_or_flight),
    assertz(in_battle),
    enemy_pokemon(X),
    poke_name(X, Y),
    write('A wild '), write(Y), write(' appears!'), nl,
    write('Fight or Run?').

fight :-
    fight_or_flight, !,
    retract(fight_or_flight).

run :- !.
    %Random

% Menghitung besar damage yang dikena musuh
calc_damage(AttackerId, DefenderId, Result) :-
    type(AttackerId, AtkType),
    type(DefenderId, DefType),
    attack(AttackerId, AtkVal),
    attack_multiplier(AtkType, DefType, Mult),
    Result is (AtkVal * Mult).

% Menghitung besar special damage yang dikena musuh
calc_special_damage(AttackerId, DefenderId, Result) :-
    type(AttackerId, AtkType),
    type(DefenderId, DefType),
    special(AttackerId, AtkVal),
    attack_multiplier(AtkType, DefType, Mult),
    Result is (AtkVal * Mult).

% Menyelesaikan battle saat musuh sudah kalah
check_death :-
    enemy_health(X),
    X =< 0,
    enemy_pokemon(Y),
    poke_name(Y, Name),
    write(Name), write(' faints! Do you want to capture it? (Use \'capture.\' to capture, otherwise move away)'),
    retract(in_battle),
    retract(special_used), !.

% Ignore bila musuh belum mati
check_death :-
    enemy_turn.

check_player_lose :-
    pokemon_inventory(_, 0),
    write('YOU LOSE :(').

check_player_lose :- !.

check_player_death :-
    selected_pokemon(SelPoke),
    pokemon_health(HP),
    nth_item(HP, SelPoke, Health),
    Health =< 0, !,
    delete_pokemon(SelPoke),
    check_player_lose.

check_player_death :-
    enemy_turn.

reduce_health([Head|Tail], 1, Dec, [Result|Tail]) :- !,
    Result is Head - Dec.

reduce_health([Head|Tail], Slot, Dec, [Head|Result]) :- !,
    NewSlot is Slot - 1,
    reduceHealth(Tail, Slot, Dec, Result).

% Pokemon musuh menyerang pemain
enemy_turn :- !,
    selected_pokemon(SelPoke),
    pokemon_inventory(Inv, Count),
    nth_item(Inv, SelPoke, PokeId),
    enemy_pokemon(EnemyId),
    calc_damage(EnemyId, PokeId, Atk),
    pokemon_health(HP),
    reduce_health(HP, SelPoke, Atk, NewHP),
    retract(pokemon_health(HP)),
    assertz(pokemon_health(NewHP)),
    check_player_death.

pokemon_exists(Slot, Name, SlotId) :-
    pokemon_inventory(Inv, Count),
    nth_item(Inv, Slot, PokeId),
    poke_name(PokeId, Name),
    SlotId is Slot, !.

pokemon_exists(Slot, Name, SlotId) :- !,
    pokemon_inventory(Inv, Count),
    Count > Slot,
    NewSlot is Slot + 1,
    pokemon_exists(NewSlot, Name, PokeId).


% Success Result: Mengubah selected_pokemon menjadi X
pick(X) :-
    in_battle, (\+ fight_or_flight),
    pokemon_exists(1, X, PokeId), !, 
    retract(selected_pokemon(AnyOne)),
    assertz(selected_pokemon(PokeId)),
    write(X), write(', I choose you!').

pick(X) :-
    fight_or_flight, !,
    write('Type \'fight.\' to fight, type \'run\' to run.').

% Fail Condition: Tidak dalam battle
pick(X) :-
    (\+ in_battle), !,
    write('You are currently not in a battle').

% Fail Condition: Angka slot tidak benar
pick(X) :-
    !,
    write('You don\'t have that Pokemon').

% Success Result: Darah musuh berkurang
attack :-
    in_battle, (\+ fight_or_flight),
    (\+ selected_pokemon(0)), !,
    enemy_health(X),
    retract(enemy_health(X)),
    selected_pokemon(SelPoke),
    pokemon_inventory(Inv, Count),
    nth_item(Inv, SelPoke, PokeId),
    enemy_pokemon(EnemyId),
    calc_damage(PokeId, EnemyId, Atk),
    NewX is X - Atk,
    assertz(enemy_health(NewX)),
    check_death.

attack :-
    selected_pokemon(0), !,
    write('You have not picked a pokemon yet').

attack(X) :-
    fight_or_flight, !,
    write('Type \'fight.\' to fight, type \'run\' to run.').

% Fail Condition: Tidak dalam battle
attack :-
    !,
    write('You are currently not in a battle').

% Success Result: Darah musuh berkurang
specialAttack :-
    in_battle, (\+ fight_or_flight), (\+ special_used),
    (\+ selected_pokemon(0)), !,
    enemy_health(X),
    retract(enemy_health(X)),
    selected_pokemon(SelPoke),
    pokemon_inventory(Inv, Count),
    nth_item(Inv, SelPoke, PokeId),
    enemy_pokemon(EnemyId),
    calc_special_damage(PokeId, EnemyId, Atk),
    NewX is X - Atk,
    assertz(enemy_health(NewX)),
    check_death.

specialAttack :-
    selected_pokemon(0), !,
    write('You have not picked a pokemon yet').

special_attack(X) :-
    fight_or_flight, !,
    write('Type \'fight.\' to fight, type \'run\' to run.').

specialAttack :-
    special_used, !,
    write('You have used a special this battle.').

% Fail Condition: Tidak dalam battle
specialAttack :-
    !,
    write('You are currently not in a battle').