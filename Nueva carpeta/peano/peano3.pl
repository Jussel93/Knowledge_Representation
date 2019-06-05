

% Peano Arithmetic
% 
%  0  - 0
%  1  - n(0)
%  2  - n(n(0))
%  3  - n(n(n(0)))

% sum(?X, ?Y, ?Z)
% it is true if Z is X + Y using Peano
% Arithmetic

sum(0, Y, Y):- peano(Y).
%  n    :-     n-1
sum(n(X), Y, n(Z)) :- sum(X, Y, Z).


% p2d(+P, -D)
% it is true if D unify with a 
% decimal number equivalen to the
% Peano representation of P 

p2d(0, 0).
p2d(n(P), Number2):- var(Number2), 
  p2d(P, Number),
  Number2 is Number + 1.
  
% d2p(+D, -P)
% it is true if P unify with a 
% Peano representation equivalent to the
% decimal number D

d2p(0, 0).
d2p(D, n(P)):- D > 0, D2 is D-1, d2p(D2, P).
  
  
% substr(?X, ?Y, ?Z)
% it is true if Z is X - Y using
% Peano arithmetic

substr(X, 0, X).
substr(X, n(Y), Z):- substr(X, Y, n(Z)).


% multiply(?X, ?Y, ?Z)
% it is tru if Z unify with X * Y in Peano Arithmetic
% it is true if Z unify with a Peano number
% equivalent to add X, Y times

multiply(X, 0, 0):- peano(X).
multiply(X, n(Y), Z2) :- multiply(X, Y, Z), 
  sum(X, Z, Z2).
  
% peano(+X)
% it is tru if X is a Peano number

peano(0).
peano(n(X)):- peano(X).

%greater_or_equal(+X, +Y)
% it is true if X is greather or equal than Y

greater_or_equal(n(X), 0):- peano(X).
greater_or_equal(X, X):- nonvar(X), peano(X).
greater_or_equal(n(X), n(Y)):- nonvar(X), 
   greater_or_equal(X, Y).
   
%greater(+X, +Y)
% it is true if X is greather or equal than Y

greater(n(X), 0):- peano(X).
greater(n(X), n(Y)):- nonvar(X), 
   greater(X, Y).   
   
% division(X?, Y?, Z?)
% it is true if Z is the integer division
% of X divided by Y. Equivalent to div using 
% Peano arithmetic. How many times is possible
% to delete Y to X.

division(X, Y, 0):- greater(Y, X).
division(X, Y, n(Z)):- substr(X, Y, X2), 
  division(X2, Y, Z).






