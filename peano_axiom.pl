% sum(X,Y,Z)
% it is true if Z is the usm of X+Y

% 1. P(n0)
% 2. P(n-1) -> P(n)

sum(0, Y, Y).    % die Summe von 0+Y ist Y --> das letzte Symbol ist das Resultat!!!

sum(n(X),Y,n(Z)) :- sum(X,Y,Z).
