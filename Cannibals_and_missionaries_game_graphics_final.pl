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

% Example for path --> path(state(3,3,right), state(0,0,_), [], Path).

draw_square(Window):-
	new(Window, picture('Game: Missionaires and Cannibals')),
	send(Window, size, size(400, 400)),
	send(Window, open).

misPos([point(9, 180), point(59, 180), point(109, 180), point(259, 180), point(309, 180), point(359, 180)]). % --> Punkte aller moeglichen Positionen der Missionaires
canPos([point(9, 220), point(59, 220), point(109, 220), point(259, 220), point(309, 220), point(359, 220)]). % --> Punkte aller moeglichen Positionen der Cannibals
 
% mis([0,0,0,1,1,1,]). --> Ausgangssituation Missionaires
% can([0,0,0,1,1,1,]). --> Ausgangssituation Cannibals

% rotateLeft(+List, +Num, -Result)
% --> it is true if Result unify with a list with the same elements than the List, but rotating Num times to the left
% rotateLeft(List,N,R). --> Nach links rotieren
rotateLeft(List, 0, List).
rotateLeft([Head|Tail], N, R):-
	N>0,
	N2 is N-1,	
	append(Tail, [Head], L2),
	rotateLeft(L2, N2, R).
% Example --> rotateLeft([1,2,3,4,5],2,R]). --> Rotate the List 2 times to the left

% rotateLeft(+List, +Num, -Result)
% --> it is true if Result unify with a list with the same elements than the List, but rotating Num times to the right
% rotateRight(List, N, R). --> Nach rechts rotieren	
rotateRight(List, 0, List).
rotateRight(List, N, R):-
	N>0,
	N2 is N-1,	
	append(L1, [Last], List),
rotateRight([Last|L1], N2, R).
% Example --> rotateRight([1,2,3,4,5],2,R]). --> Rotate the List 2 times to the right


% moveGraphic gives us the new positions of the Missionaires and the Cannibals
% moveGraphic(+Window, +State, +Path, +ListElements)
% stateGraphic(MisStateList, CanStateList)
% state([0,0,0,1,1,1,], [0,0,0,1,1,1,]
% --> it is true if a graphic representation of the Path as a list of movements 

moveGraphic(_, [], _).
  
moveGraphic(Window, state(MisGraphState, CanGraphState), [move(Mis, Can, left)| Tail], ElementsList):-
  rotateLeft(MisGraphState, Mis, NewMisGraphState),
  rotateLeft(CanGraphState, Can, NewCanGraphState),
  % Delete elements
  deleteElements(ElementsList),
  % Paint new State
  misPos(MisPos), canPos(CanPos),
  paintState(state(NewMisGraphState, NewCanGraphState), MisPos, CanPos, Window, _),  
  % Delay time
  sleep(1),
  % write(state(NewMisGraphState, NewCanGraphState)),
  % write(nl),
  moveGraphic(Window, state(NewMisGraphState, NewCanGraphState), Tail).
  
moveGraphic(Window, state(MisGraphState, CanGraphState), [move(Mis, Can, right)| Tail], ElementsList):-
  rotateRight(MisGraphState, Mis, NewMisGraphState),
  rotateRight(CanGraphState, Can, NewCanGraphState),
  % Delete elements
  deleteElements(ElementsList),
  % Paint new State
  misPos(MisPos), canPos(CanPos),
  paintState(state(NewMisGraphState, NewCanGraphState), MisPos, CanPos, Window, NewElements),
  % Delay time
  sleep(1),
  % write(state(NewMisGraphState, NewCanGraphState)),
  % write(nl),
  moveGraphic(Window, state(NewMisGraphState, NewCanGraphState), Tail, NewElements).  
  
% Command --> moveGraphic(state([0,0,0,1,1,1,], [0,0,0,1,1,1,]), P).

solution :-  path(state(3,3,right), state(0,0,_), [], P), draw_square(Window), moveGraphic(Window, state([0,0,0,1,1,1], [0,0,0,1,1,1]), P, []). 

% --> delete the elements from ElementsList to clear the window 
deleteElements([]).
deleteElements([Head|Tail]):-
  free(Head),
  deleteElements(Tail).

% paintState(+GraphicsState, +MisPos, +CanPos, +Window, -ElementsList).  
% --> paint the positions of the cannibals and missionaries from the ElementsList
paintState(state([], []), _, _, _, []).
paintState(state([HeadMis|TailMis], [HeadCan|TailCan]), 
  [HeadPosMis|TailPosMis], [HeadPosCan|TailPosCan], Window, 
  [BitmapMis, BitmapCan|BitmapList]):-  
  drawMis(Window, HeadMis, HeadPosMis, BitmapMis),
  drawCan(Window, HeadCan, HeadPosCan, BitmapCan),
  paintState(state(TailMis, TailCan), TailPosMis, TailPosCan, Window, BitmapList).
  
paintOneState :- draw_square(Window), 
  misPos(MisPos), canPos(CanPos),
  paintState(state([0,0,0,1,1,1], [0,0,0,1,1,1]), MisPos, CanPos, Window, _).  

% --> draw the Cannibals 
% --> if the number is 0 nothing happens
% --> if the number is 1 it will be send to the point
drawCan(_, 0, _, _).
drawCan(Window, 1, point(X, Y), Bitmap1):- 
        send(Window, display,
          new(Bitmap1, bitmap('32x32/cannibal.xpm')), point(X,Y)).

% --> draw the Missionaires 	
% --> if the number is 0 nothing happens
% --> if the number is 1 it will be send to the point	  
drawMis(_, 0, _, _).		  
drawMis(Window, 1, point(X, Y), Bitmap1):- 
        send(Window, display,
          new(Bitmap1, bitmap('32x32/angel.xpm')), point(X,Y)).
