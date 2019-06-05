

% Cannibals and Missionaires Game

% 1. State Representation
% state(+MissionairesRight, +CannibalsRight, +BoatSide)


% 1. Only two people maximum in the boat and 1 people minimum
% 2. No more Cannibals than Missionaires at any side


% Initial State
state(3, 3, right).


% Final State
state(0, 0, _).


% 2. Movements
% People to the left

mov( move(M, C, left), state(MR, CR, right), state(NMR, NCR, left)):- 
 move(M,C,left),
 M =< MR, C =< CR, % move if we have people 
 NMR is MR - M, NCR is CR - C, % new people to the right
 \+ not_valid(NMR, NCR).
 
 
mov( move(M,C, right), state(MR, CR, left), state(NMR, NCR, right)):-
 move(M, C, right),
 ML is 3 - MR, CL is 3 - CR, % initial people to the left
 M =< ML, C =< CL, % enough people to the left to move
 NMR is MR + M, NCR is CR + C, % new people to the right
 \+ not_valid(NMR, NCR).
 
move(0, 1, _).
move(1, 0, _).
move(1, 1, _). 
move(2, 0, _). 
move(0, 2, _). 


not_valid(1,2).
not_valid(2,3).
not_valid(1,3).
not_valid(2,1).
not_valid(2,0).


path(Ini, Ini, _ , []).
path(Ini, Fin, Visited, [move(M,C,Side)|Path]):-
  mov( move(M, C, Side), Ini, Temp),
  \+ member(Temp, Visited),
  path(Temp, Fin, [Temp|Visited], Path).

 
 
 
 
 
 
 
 
 
 
 
