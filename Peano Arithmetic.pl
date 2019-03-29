% Peano Arithmetic
%
% 0 - 0
% 1 - n(0)
% 2 - n(n(0))

% sum( ?X, ?Y, ?Z)
% it is true if Z is X+Y using Peano Arithmetic

sum(0,Y,Y).

% 	n 			 :- 	n-1
sum(n(X),Y,n(Z)) :- sum(X,Y,Z).

% p2d(+P, -D)
% it is true if D unify with a decimal number
% equivalent to the Peano representation
% of P

p2d(0,0).

p2d(n(P), D2):-p2d(P,D),
  D2 is D +1.

% substr(?x,?Y,?Z)
% it is true if Z is X-Y in using
% Peano arithmetic

substr(X,0,X).

substr(X,n(Y),Z):- substr(X,Y,n(Z)).
  