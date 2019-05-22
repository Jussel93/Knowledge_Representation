% Hanoi Game

%		|		   |		   |
%		|		   |		   |
%	 -------	-------		-------
%		A		   B		   C
%
% The goal of this game is move N discs from A to C using
% B as auxiliarz toewr. The restriction for this game is
% that is not possible to put one disc over other with smaller
% size. 
%
% 1. Move n-1 discs from A to B using C as axiliary tower
% 2. Move 1st disc from A to C
% 3. Move n-1 discs from B to C using A as auxiliary tower 
%

% hanoi (+Num, +A, +B, +C, Result).
% it is true if Result unifz with a list of movements to
% translate Num discs from tower A to C useing B as auxiliary tower.

hanoi(1, A, _, C, [move(A,C)]).
% Bei nur einer Disc braucht man Turm B nicht weil keine Zwischenablage benoetigt wird.

hanoi(N, A, B, C, R):-
	N2 is N-1,
	hanoi(N2, A, C, B, R1),  % Moving N2 from A to B using C as auxiliary --> C wird als Ablage benoetigt! hinten steht der Turm auf den es soll, in der Mitte der Ablageturm
	hanoi(1, A, _, C, R2),
	hanoi(N2, B, A, C, R3),
	append([R1, R2, R3], R).
	% R --> result with all elements --> diese Liste umfasst alle Zwischenschritte R1, R2, R3
	
	
% hanoi(3, a, b, c, R), write(R).  --> 3 Disks werden bewegt und R ist die Liste mit Schritten die getaetigt werden muessen!
	
	
	