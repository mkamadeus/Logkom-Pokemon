/* File : pokemon.pl */
/* Place to store Pokemon Facts */

% ID and Name
poke_name(1, "Bulbasaur").
poke_name(4, "Charmander").
poke_name(7, "Squirtle").
poke_name(152, "Chikorita").
poke_name(155, "Cyndaquil").
poke_name(158, "Totodile").
poke_name(722, "Rowlet").
poke_name(725, "Litten").
poke_name(728, "Popplio").
poke_name(888, "Professor Oak").
poke_name(999, "Tuan Yon").

% Encounter Weight
encounter_weight(1, 90).
encounter_weight(4, 90).
encounter_weight(7, 90).
encounter_weight(152, 70).
encounter_weight(155, 70).
encounter_weight(158, 70).
encounter_weight(722, 50).
encounter_weight(725, 50).
encounter_weight(728, 50).
encounter_weight(888, 10).
encounter_weight(999, 5).

% Pokemon Type
type(1, grass).
type(4, fire).
type(7, water).
type(152, grass).
type(155, fire).
type(158, water).
type(722, grass).
type(725, fire).
type(728, water).
type(888, grass).
type(999, fire).

% Base health
health(1, 45).
health(4, 39).
health(7, 44).
health(152, 45).
health(155, 39).
health(158, 50).
health(722, 68).
health(725, 45).
health(728, 50).
health(888, 100).
health(999, 100).

% Base attack
attack(1, 45).
attack(4, 39).
attack(7, 44).
attack(152, 45).
attack(155, 39).
attack(158, 50).
attack(722, 68).
attack(725, 45).
attack(728, 50).
attack(888, 100).
attack(999, 100).

% Attack Calculation
calc_attack(Id, Level, Attack):-attack(Id, Base), Attack is ((Base*Level) // 50) + 5.

% Health Calculation
calc_health(Id, Level, Health):-attack(Id, Base), Health is ((Base*Level) // 50) + Level + 10.
