

% Hanoi Game
% 
%     |       |      |
%     |       |      |
%   -----   -----  -----
%     A       B      c

% The goal of this game is move N discs from A to C using 
% B as auxiliary tower. The restriction for this game is
% that is not possible to put one disc over other with smaller
% size.

% 1. Move n-1 discs from A to B using C as auxiliary tower.
% 2. Move 1st disc form A to C
% 3. Move n-1 discs from B to C using A as auxiliary tower. 

% hanoi(+Num, +A, +B, +C, -Result).
% it is true if Result unify with a list of movements to 
% translate Num discs from tower A to C using B as auxiliary tower.

hanoi(1, A, _, C, [move(A,C)]).

hanoi(N, A, B, C, R):-
 N2 is N-1,
 hanoi(N2, A, C, B, R1),
 hanoi(1, A, _, C, R2),
 hanoi(N2, B, A , C, R3),
 append([R1, R2, R3], R).
 
 


