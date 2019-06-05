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

% path(state(3,3right), state(0,0,=,[],P), write(P)

draw_square:-
	new(Window, picture('Missionaires and Cannibals')),
	send(Window, size, size(400, 400)),
	send(Window, open).

	
misPos([point(9, 180), point(59, 180), point(109, 180), point(259, 180), point(309, 180), point(359, 180)]).
canPos([point(9, 220), point(59, 220), point(109, 220), point(259, 220), point(309, 220), point(359, 220)]).


% translateState(state(MisRight, Canright, Side), state(MisPos, CanPos


% mis([0,0,0,1,1,1,]).
% can([0,0,0,1,1,1,]).

% rotateLeft(List, N,R). --> Nach links rotieren

rotateLeft(List, 0, List).
rotateLeft([Head|Tail], N, R):-
	N>0,
	N2 is N-1,	
	append(Tail, [Head], L2),
	rotateLeft(L2, N2, R).
% --> rotateLeft([1,2,3,4,5],2,R]).

% rotateRight(List, N, R). --> Nach rechts rotieren	
rotateRight(List, 0, List).
rotateRight(List, N, R):-
	N>0,
	N2 is N-1,	
	append(L1, [Last], List),
rotateRight([Last|L1], N2, R).

moveGraphic(_, []).

moveGraphic(Window, state(MisGraphState, CanGraphState), [move(Mis, Can, left)|Tail]):-
	rotateLeft(MisGraphState, Mis, NewMisGraphState),
	rotateLeft(CanGraphState, Can, NewCanGraphState),
	% Delete elements
	% Paint new State
	misPos(MisPos),canPos(CanPos),
	paintState(state(NewMisGraphState, NewCanGraphState), MisPos, CanPos, Window, _),
	% Delay time
	sleep(1),
	% write(state(NewMisGraphState, NewCanGraphState)),
	% write(n1),
	moveGraphic(state(NewMisGraphState, NewCanGraphState),Tail).
	
	
moveGraphic(Window, state(MisGraphState, CanGraphState), [move(Mis, Can, right)|Tail]):-
	rotateRight(MisGraphState, Mis, NewMisGraphState),
	rotateRight(CanGraphState, Can, NewCanGraphState),
	% Delete elements
	% Paint new State
	misPos(MisPos),canPos(CanPos),
	paintState(state(NewMisGraphState, NewCanGraphState), MisPos, CanPos, Window, _),	
	% Delay time
	sleep(1),
	% write(state(NewMisGraphState, NewCanGraphState)),
	% write(n1),
	moveGraphic(Window, state(NewMisGraphState, NewCanGraphState),Tail).
		

solution :- path(state(3,3,right), state(0,0, _),[],P), draw_square(Window), moveGraphic(Window, state([0,0,0,1,1,1,], [0,0,0,1,1,1,]), P).
% Befehl--> moveGraphic(state([0,0,0,1,1,1,], [0,0,0,1,1,1,]), P).

paintState(state([HeadMis|TailMis], [HeadCan|TailCan]), 
	[HeadPosMis|TailPosMis], [HeadPosCan|TailPosCan],
	Window,[BitmapMis, BitmapCan|BitmapList]):-
	drawMis(Window, HeadMis, HeadPosMis, BitmapMis),
	drawCan(Window, HeadCan, HeadPosCan, BitmapCan),
	paintState(state(TailMis, TailCan), TailPosCan, TailPosMis, Window, BitmapList)).
	
paintOneState :- draw_square(Window),
	misPos(MisPos), canPos(CanPos),
	paintState(state([0,0,0,1,1,1,], [0,0,0,1,1,1,]), MisPos, CanPos, Window, _).
	
	
drawCan(_, 0, _, _).	
drawCan(Window, 1, point(X,Y), BitMap1):-
		send(Window, display,
			new(BitMap1, bitmap('cannibal.xpm')), point(X, Y)).
drawMis(_, 0, _, _).				
drawMis(Window, 1, point(X,Y),Bitmap1):-
	send(Window, display,
			new(BitMap1, bitmap('angel.xpm')), point(X, Y)). 

% zum zeichnen den Befehl draw_square. benutzen
% Ausfuehren mit solution.

