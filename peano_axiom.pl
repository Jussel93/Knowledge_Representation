% sum(X,Y,Z)
% it is true if Z is the usm of X+Y

% 1. P(n0)
% 2. P(n-1) -> P(n)

sum(0, Y, Y).    % die Summe von 0+Y ist Y --> das letzte Symbol ist das Resultat!!!

sum(n(X),Y,n(Z)) :- sum(X,Y,Z).


% substr(?X, ?Y, ?Z)
% it is true if Z is X-Y.

substr(X,Y,Z):-sum(Z,Y,X).

% multiply(?X,?Y,?Z)
%it is true if Z is X*Y.
% it is true if Z is the result of sum X Y times. 
multiply(_,0,0).

% multiplz (n-1, ... ) -> multiply(n,...)			wenn das erste "true" ist dann ist das zweite auch "true"
----------------------------------------------
%		n					n-1
multiply(X, n(Y), Z2) :- multiplz (X,Y,Z), sum(Z,X, Z2).

