% There must be more missionaries on the side then cannibals
% Maximum 2 people on the boat
% All have to change the side from right to left


% 1. State representation
% state(+MissionariesRight, +CannibalsRight, +BoatSide)

% Initial state
% state(3,3, right)

% Final state
% state(0,0, _)

% 2. Movements
% People to the left
% L = Boat left 	R = Boat right
% mov(move(M, C, L),stateBEFORE(), stateAFTER())

mov(move(M, C, left),state(MR, CR, right), state(NMR, NCR, left)):-
	move(M,C,left),
	M =< MR, C =< CR, %  move if we have people
	NMR is MR - M, NCR is CR - C, % new people on the right
	\+ not_valid(NMR, NCR).	

	
	
mov(move(M, C, right), state(MR, CR, left), state(NMR, NCR, right)):-
	move(M, C, right),
	ML is 3 - MR, CL is 3 - CR,
	M =< ML, C =< CL, %  move if we have people
	NMR is MR + M, NCR is CR + C, % new people on the right
	\+ not_valid(NMR, NCR).
	
% valid(MR,CR)	
move(0, 1, _).
move(0, 2, _).
move(1, 0, _).
move(1, 1, _).
move(2, 0, _).

% not_valid(MR,CR)
not_valid(1,2).
not_valid(1,3).
not_valid(2,0).
not_valid(2,1).
not_valid(2,3).



path(Ini, Ini, _, []).

path(Ini, Final, Visited, [move(M,C,Side)|Path]):-
	mov( move(M,C,Side), Ini, Temp),
	\+ member(Temp, Visited),   
	path(Temp, Final, [Temp|Visited], Path).


	
	% path(state(3,3,right),state(0,0,_), [], Path), length(Path,11) write(Path).  % Path in den Klammern gross schreiben weil es sonst eine Konstante waere und keine Variable

% Possible Movements
% 1. 2 Missionaries right to left boat right
% 2. 2 Cannibals right to left boat right
% 3. 1 Missionarie & 1 cannibal right to left boat right
% 4. 1 Missionarie right to left boat right
% 5. 1 Cannibal right to left boat right
% 6. 2 Missionaries left to right boat left
% 7. 2 Cannibals left to right boat left
% 8. 1 Missionarie & 1 cannibal left to right boat left
% 9. 1 Missionarie left to right boat left
% 10. 1 Cannibal left to right boat left


% cannibalsleft = CL 	cannibalsright = CR 	
% missionariesleft = ML missionariesright = MR 
% Boat = B

% 1. CL = 3 ML = 3 B = L CR = 0 MR = 0
% 2. CL = 2 ML = 2 B = R CR = 1 MR = 1
% 3. CL = 2 ML = 3 B = L CR = 1 MR = 0