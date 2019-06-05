
%sum(?X, ?Y, ?Z)
% it is true if Z is the sum of X + Y.


% 1. P(n0)
% 2. P(n-1) -> P(n)


sum(0, Y, Y).

% P(n)           <- P(n-1)
% ----------    -----------
sum(n(X), Y, n(Z)) :- sum(X, Y, Z).

% substr(?X, ?Y, ?Z)
% it is true if Z is X - Y.

substr(X, Y, Z):- sum(Z, Y, X).

% multiply(?X, ?Y, ?Z)
% it is true if Z is X * Y. 
% it is true if Z is the result of sum X,  Y times.
multiply(_, 0, 0).

% multiply(n-1, ....) -> multiply(n, ....)
% -------------------------------------------
%    n               n-1

multiply(X, n(Y), Z2):- multiply(X, Y, Z), sum(X, Z, Z2).



