
% Game of sailing
%
% map(MaxX, MaxY).

% state(pos(X,Y)).
% map(MaxX, MaxY)

map(20,20).

valid(X,Y):- map(MaxX, MaxY), X >= 0, Y >= 0,
			X =< MaxX, Y =< MaxY. 
% Speed --> wird direkt nach der Richtung aufgefuehrt kann 1,2 oder 4 sein!			
	

% Starboard movements	--> rechte Seite
mov(running, 1, state(X,Y), state(X, Y2)):- Y2 is Y-1, valid(X, Y2). 
mov(stboar_clhauled, 4, state(X, Y), state(X2,Y2)):- 
	X2 is X + 1, Y2 is Y + 1, valid(X2,Y2).  % Nach dem Punkt werden die Variablen neu deklariert
mov(stboar_beam_reach, 2, state(X,Y), state(X2, Y)):-
	X2 is X + 1, valid(X2,Y).  % Nach dem Punkt werden die Variablen neu deklariert
mov(stboar_broad_reach, 1, state(X,Y), state(X2, Y2)):-
	X2 is X+1, Y2 is  Y-1, valid(X2,Y2). 

% Port movements		--> linke Seite
mov(port_clhauled, 4, state(X, Y), state(X2,Y2)):- 
	X2 is X - 1, Y2 is Y + 1, valid(X2,Y2).  % Nach dem Punkt werden die Variablen neu deklariert
mov(port_beam_reach, 2, state(X,Y), state(X2, Y)):-
	X2 is X - 1, valid(X2,Y).  % Nach dem Punkt werden die Variablen neu deklariert
mov(port_broad_reach, 1, state(X,Y), state(X2, Y2)):-
	X2 is X-1, Y2 is  Y-1, valid(X2,Y2). 	
	
	
% path(+Ini, +Fin, +Visited, -Path, -Time).	
% it is true if Path unify with the list of movements to go to
% from position Ini to positin Fin without repeating Visited
% positions. time unify with th total path time.


path(Ini, Ini, _, [], 0).  % Visited bleibt hierbei unberuecksichtigt, weil kein Schritt gemacht wird und der Path bleibt leer und die Zeit bleibt Null

path(Ini, Fin, Visited, [Mov|Path], TotalTime):-  % Mov gibt den Startpunkt an der zu Path ergaenzt wird!
	mov(Mov, TimeMov, Ini, Temp),
	\+ member(Temp, Visited),
	path(Temp, Fin, [Temp|Visited], Path, Time),  % Temp ist der neue Schritt in der Liste von Visited
	TotalTime is Time + TimeMov.	% Die neue Zeit ist die Startzeit Time + die Zeit der Einzelschritte TimeMov
	
	
% path(state(0,0), state(20,20), [state(0,0)], Path, Time).	
