% Untuk memulai battle, run init_battle
% Command yang dibuka untuk player ada pada prosedur yang bersangkutan

%:- include('pokemon.pl').
%:- include('player.pl').

% selected_pokemon(IdSlot)
:- dynamic(selected_pokemon/1).

:- dynamic(enemy_pokemon/1).

:- dynamic(enemy_health/1).

:- dynamic(fight_or_flight/0).

% Ada bila player sedang battle
:- dynamic(in_battle/0).

:- dynamic(special_used/0).

% attack_multiplier(AttackType, DefendType, Multiplier)
attack_multiplier(normal,   normal, 1).     attack_multiplier(normal,   fire, 1).       attack_multiplier(normal,   water, 1).      attack_multiplier(normal,   grass, 1).      attack_multiplier(normal,   psychic, 1).    attack_multiplier(normal,   dark, 1).       attack_multiplier(normal,   fighting, 1).
attack_multiplier(fire,     normal, 1).     attack_multiplier(fire,     fire, 1).       attack_multiplier(fire,     water, 0.5).    attack_multiplier(fire,     grass, 1.5).    attack_multiplier(fire,     psychic, 1).    attack_multiplier(fire,     dark, 1).       attack_multiplier(fire,     fighting, 1).
attack_multiplier(water,    normal, 1).     attack_multiplier(water,    fire, 1.5).     attack_multiplier(water,    water, 1).      attack_multiplier(water,    grass, 0.5).    attack_multiplier(water,    psychic, 1).    attack_multiplier(water,    dark, 1).       attack_multiplier(water,    fighting, 1).
attack_multiplier(grass,    normal, 1).     attack_multiplier(grass,    fire, 0.5).     attack_multiplier(grass,    water, 1.5).    attack_multiplier(grass,    grass, 1).      attack_multiplier(grass,    psychic, 1).    attack_multiplier(grass,    dark, 1).       attack_multiplier(grass,    fighting, 1).
attack_multiplier(dark,     normal, 1).     attack_multiplier(dark,     fire, 0.5).     attack_multiplier(dark,     water, 1.5).    attack_multiplier(dark,     grass, 1).      attack_multiplier(dark,     psychic, 2).    attack_multiplier(dark,     dark, 0.5).     attack_multiplier(dark,     fighting, 0.5).
attack_multiplier(psychic,  normal, 1).     attack_multiplier(psychic,  fire, 0.5).     attack_multiplier(psychic,  water, 1.5).    attack_multiplier(psychic,  grass, 1).      attack_multiplier(psychic,  psychic, 0.5).  attack_multiplier(psychic,  dark, 0.5).     attack_multiplier(psychic,  fighting, 2).
attack_multiplier(fighting, normal, 1).     attack_multiplier(fighting, fire, 0.5).     attack_multiplier(fighting, water, 1.5).    attack_multiplier(fighting, grass, 1).      attack_multiplier(fighting, psychic, 0.5).  attack_multiplier(fighting, dark, 2).       attack_multiplier(fighting, fighting, 0.5).

% Melakukan inisialisasi battle
init_battle :-
    assertz(fight_or_flight),
    assertz(in_battle),
    assertz(can_run),
    enemy_pokemon(X),
    poke_name(X, Y),
    write('A wild '), write(Y), write(' appears!'), nl,
    write('Fight or Run?').

fight :- in_battle,
    fight_or_flight, !,
    write('You choose to face the Pokemon head on. Choose your Pokemon!'),
    retract(fight_or_flight).
fight :- 
    (\+ in_battle), !,
    write('You aren\'t in a battle Broo, meet a wild Pokemon first to fight.').
fight :- 
    (\+ fight_or_flight), !,
    write('Choose your Pokemon by typing \'pick(your_pokemon)\' command !').

run_success(R) :-
    R >= 0, !,
    retract(in_battle),
    retract(fight_or_flight),
    write('You choose to run. You successfully escaped from the wild Pokemon.').
    %Random

run_success(R) :-
    R < 0, !,
    write('You can\'t escape from the wild Pokemon. Meet your luck.').

run :- 
    can_run,
    in_battle,
    fight_or_flight, 
    random(-3,2,R),
    retract(can_run),
    run_success(R).
run :-
    (\+ in_battle),!,
    write('You aren\'t in a battle broo.').
run :-
    (\+ fight_or_flight), !,
    write('It isn\'t right time for choose that Broo.').
run :-
    (\+ can_run),
    write('Meet your fate, You aren\'t able to run this time.').

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
    write(Name), write(' faints! Do you want to capture it? (Use \'capture.\' to capture, otherwise move away)'), !,
    retract(in_battle),
    retract(selected_pokemon(_)),
    assertz(selected_pokemon(0)), !,
    retract(special_used).

% Ignore bila musuh belum mati
check_death :- 
    show_battle_status, 
    nl, nl, 
    enemy_turn.

check_player_lose :- !,
    pokemon_inventory(_, 0),
    retract(game_start(true)),
    asserta(game_start(false)),
    write('YOU LOSE :('), !.

check_player_lose :- !,
    write('Your Pokemon fainted! Fainted Pokemons cannot be resurrected. Choose another Pokemon to battle!').

check_player_death :-
    selected_pokemon(SelPoke),
    pokemon_health(HP),
    nth_item(HP, SelPoke, Health),
    Health =< 0, !,
    delete_pokemon(SelPoke),
    retract(selected_pokemon(SelPoke)),
    assertz(selected_pokemon(0)),

    check_player_lose, !.

check_player_death :-
    show_battle_status, !.

reduce_health([Head|Tail], 1, Dec, [Result|Tail]) :- !,
    Result is Head - Dec.

reduce_health([Head|Tail], Slot, Dec, [Head|Result]) :- !,
    NewSlot is Slot - 1,
    reduce_health(Tail, NewSlot, Dec, Result).

% Pokemon musuh menyerang pemain
enemy_turn :- !,
    selected_pokemon(SelPoke),
    pokemon_inventory(Inv, _),
    nth_item(Inv, SelPoke, PokeId),
    enemy_pokemon(EnemyId),
    calc_damage(EnemyId, PokeId, Atk),
    pokemon_health(HP),
    reduce_health(HP, SelPoke, Atk, NewHP),
    retract(pokemon_health(HP)),
    assertz(pokemon_health(NewHP)), !,

    write('It deals '), write(Atk), write(' damage to your Pokemon!'), nl, nl,

    check_player_death.

pokemon_exists(Slot, Name, SlotId) :-
    pokemon_inventory(Inv, _),
    nth_item(Inv, Slot, PokeId),
    poke_name(PokeId, Name),
    SlotId is Slot, !.

pokemon_exists(Slot, Name, SlotId) :- !,
    pokemon_inventory(_, Count),
    Count > Slot,
    NewSlot is Slot + 1,
    pokemon_exists(NewSlot, Name, SlotId).


% Success Result: Mengubah selected_pokemon menjadi X
pick(X) :-
    in_battle, (\+ fight_or_flight),
    pokemon_exists(1, X, PokeId), !, 
    retract(selected_pokemon(_)),
    assertz(selected_pokemon(PokeId)),
    write(X), write(', I choose you!'), nl, nl,
    show_battle_status.

pick(_) :-
    fight_or_flight, !,
    write('Type \'fight.\' to fight, type \'run\' to run.').

% Fail Condition: Tidak dalam battle
pick(_) :-
    (\+ in_battle), !,
    write('You are currently not in a battle').

% Fail Condition: Angka slot tidak benar
pick(_) :-
    !,
    write('You don\'t have that Pokemon').

% Success Result: Darah musuh berkurang
attack :-
    in_battle, (\+ fight_or_flight),
    (\+ selected_pokemon(0)), !,

    enemy_health(X),
    retract(enemy_health(X)),
    selected_pokemon(SelPoke),
    pokemon_inventory(Inv, _),
    nth_item(Inv, SelPoke, PokeId),
    enemy_pokemon(EnemyId),
    calc_damage(PokeId, EnemyId, Atk),
    NewX is X - Atk,
    assertz(enemy_health(NewX)),
    
    write('You deal '), write(Atk), write(' damage to the enemy!'), nl, nl,

    check_death.

attack :-
    selected_pokemon(0), !,
    write('You have not picked a pokemon yet').

attack :-
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
    pokemon_inventory(Inv, _),
    nth_item(Inv, SelPoke, PokeId),
    enemy_pokemon(EnemyId),
    calc_special_damage(PokeId, EnemyId, Atk),
    NewX is X - Atk,
    assertz(enemy_health(NewX)),
    assertz(special_used),
    
    write('You deal '), write(Atk), write(' damage to the enemy!'), nl, nl,

    check_death.

specialAttack :-
    selected_pokemon(0), !,
    write('You have not picked a pokemon yet').

specialAttack :-
    fight_or_flight, !,
    write('Type \'fight.\' to fight, type \'run\' to run.').

specialAttack :-
    special_used, !,
    write('You have used a special this battle.').

% Fail Condition: Tidak dalam battle
specialAttack :-
    !,
    write('You are currently not in a battle').





show_battle_status :-
    /* Enemy Status */
    enemy_pokemon(EnemyId),
    poke_name(EnemyId, EnemyName),
    enemy_health(EnemyHealth),
    type(EnemyId, EnemyType),

    write('Enemy:'), nl,
    write(EnemyName), nl,
    write('Health: '), write(EnemyHealth), nl,
    write('Type: '), write(EnemyType), nl,

    nl,
    selected_pokemon(SlotId),
    pokemon_inventory(Inv, _),
    nth_item(Inv, SlotId, PokeId),
    poke_name(PokeId, PokeName),
    pokemon_health(HPs),
    nth_item(HPs, SlotId, PokeHealth),
    type(PokeId, PokeType),

    write('Your Pokemon:'), nl,
    write(PokeName), nl,
    write('Health: '), write(PokeHealth), nl,
    write('Type: '), write(PokeType), nl, !.