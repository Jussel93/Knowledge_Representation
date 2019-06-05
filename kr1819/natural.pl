

% natural(Number)
% it is tru if Number is a natural number.

natural(1).

natural(N) :- N > 1, N2 is N - 1, natural(N2).

