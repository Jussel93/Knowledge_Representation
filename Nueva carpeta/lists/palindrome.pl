

% palindrome(+List) 
% it is true if List is a palindrome.
%
% palindrome([a,b,c,b,a]).
% true
%
% palindrome([a,z,c,b,t]).
% false

palindrome(L) :- reverse(L, L).


% myReverse(+List, -Result)
% it is true if Result unify with a list with
% same elements that List contains but in reverse order.

% myReverse([1,2,3,4], R).
% R = [4,3,2,1]

% Induction 
%
% 1) p(n0)
% 2) p(n-1) -> p(n)
%    p(N):- N2 is N-1, p(N2).

myReverse([], []).

myReverse([Head|Tail], R2):- myReverse(Tail, R), 
  append(R,[Head], R2).

% [1,2,3,4] -> [4,3,2,1]
%   [2,3,4] -> [4,3,2]













