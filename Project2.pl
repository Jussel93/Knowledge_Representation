

:- use_module(library(pce)).

window_size(400, 400).

draw_square :-
	window_size(MaxX, MaxY),
	new(Window, picture('my window')),
	send(Window, size, size(MaxX, MaxY)),
	send(Window, open),
	draw_lines(Window),
	initialState(_, CanInitialState),
	canPos(CanPosList),
	draw_initial_can(Window, CanInitialState, CanPosList, _).
	
	
	% right 
	% MX1R is (MaxX div 2 +59), MY1R is (MaxY div 2 - 20), % 20 space over
	% draw_angel(Window, MX1R, MY1R, _), % Missionar 1 zeichnen
	% MX2R is (MaxX div 2 +109), MY2R is MY1R,
	% draw_angel(Window, MX2R, MY2R, _), % Missionar 2 zeichnen
	% MX3R is (MaxX div 2 +159), MY3R is MY1R,
	% draw_angel(Window, MX3R, MY3R, _), % Missionar 3 zeichnen
	% CX1R is MX1R, CY1R is (MaxY div 2 + 52), % 20 space + 32 picture size
	% draw_cannibal(Window, CX1R, CY1R, _), % Kannibale 1 zeichnen
	% CX2R is MX2R, CY2R is CY1R,
	% draw_cannibal(Window, CX2R, CY2R, _), % Kannibale 2 zeichnen
	% CX3R is MX3R, CY3R is CY1R,
	% draw_cannibal(Window, CX3R, CY3R, _), % Kannibale 3 zeichnen
	% Left
	% MX1L is (MaxX div 2 -91), MY1L is (MaxY div 2 - 20), % 20 space over
	% draw_angel(Window, MX1L, MY1L), % Missionar 1 zeichnen
	% MX2L is (MaxX div 2 -141), MY2L is MY1L,
	% draw_angel(Window, MX2L, MY2L), % Missionar 2 zeichnen
	% MX3L is (MaxX div 2 -191), MY3L is MY1L,
	% draw_angel(Window, MX3L, MY3L), % Missionar 3 zeichnen
	% CX1L is MX1L, CY1L is (MaxY div 2 + 52), % 20 space + 32 picture size
	% draw_cannibal(Window, CX1L, CY1L), % Kannibale 1 zeichnen
	% CX2L is MX2L, CY2L is CY1L,
	% draw_cannibal(Window, CX2L, CY2L), % Kannibale 2 zeichnen
	% CX3L is MX3L, CY3L is CY1L,
	% draw_cannibal(Window, CX3L, CY3L). % Kannibale 3 zeichnen	

	
% initialState(ListMisPos, ListCanPos) --> Start mit den Listen fuer Mis und Can
% initialState([0,0,0,1,1,1],[0,0,0,1,1,1]) --> Ausgangssituation

misPos([point(9, 180), point(59, 180), point(109, 180), point(259, 180), point(309, 180), point(359, 180)]
canPos([point(9, 220), point(59, 220), point(109, 220), point(259, 220), point(309, 220), point(359, 220)]
%	misPos([HeadMisPos|TailMisPos]),
%	canPos([HeadCanPos|TailCanPos]),

draw_initial_can(_, [], [], []).
	
draw_initial_can(Window,[0|TailCanState], [HeadCanPos|TailCanPos], [C1|CanList]):-
	draw_cannibal(Window, HeadCanPos, C1),
	draw_initial_can(Window, TailCanState, TailCanPos, CanList).

draw_initial_can(Window,[1|TailCanState], [_|TailCanPos], [C1|CanList]):-
	draw_initial_can(Window, TailCanState, TailCanPos, CanList).

% -->
	
draw_lines(Window):-
	window_size(MaxX, MaxY),
	X11 is (MaxX div 2 + 50),
	Y11 is MaxY,
	X12 is X11, Y12 is 0,
	send(Window, display, new(Pa, path)),
		(
			send(Pa, append, point(X11, Y11)),
			send(Pa, append, point(X12, Y12))
		),
		X21 is (MaxX div 2 - 50), Y21 is MaxY,
		X22 is X21, Y22 is 0,
	send(Window, display, new(Pa2, path)),
		(
			send(Pa2, append, point(X21, Y21)),
			send(Pa2, append, point(X22, Y22))
		).		

			
% zum zeichnen den Befehl draw_square. benutzen

	draw_cannibal(Window, point(X, Y), BitMap):-
		send(Window, display,
			new(BitMap, bitmap('cannibal.xpm')), point(X, Y)),
			sleep(1).
	draw_angel(Window, point(X, Y), BitMap):-
		send(Window, display,
			new(BitMap, bitmap('angel.xpm')), point(X, Y)),
			sleep(1).		