% move(mov(M,C,left), MisPos, CanPos, Mis, Can).

misPos([point(9, 180), point(59, 180), point(109, 180), point(259, 180), point(309, 180), point(359, 180)]
canPos([point(9, 220), point(59, 220), point(109, 220), point(259, 220), point(309, 220), point(359, 220)]

mis([0,0,0,1,1,1,]).
can([0,0,0,1,1,1,]).

% rotateLeft(List, N,R). --> Nach links rotieren

rotateLeft(List, 0, List).
rotateLeft([Head|Tail], N, R2):-
	N>0,
	N2 is N-1,	
	append(Tail, [Head], R),
	rotateLeft(R, N2, R2).

% rotateLeft(List, N,R). --> Nach rechts rotieren	
rotateRight(List, 0, List).
rotateRight(List, N, ):-
	N>0,
	N2 is N-1,	
	append(L1, [Last], List),
	rotateRight([Last|L1], N2, R).
