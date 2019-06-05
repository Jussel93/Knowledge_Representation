

% myLength(List, Result)
% it is true if Rusult unify with the length of
% List

myLength([], 0).

% | -> [Head|Tail] = [1,2,3,4,5]
% Head = 1
% Tail = [2,3,4,5]

% if myLength(n-1) -> myLength(n)


%       P(n)           <-          P(n-1)   
% -------------------     -----------------------
myLength([_|Tail], Result2) :- 
   myLength(Tail, Result), Result2 is Result + 1.

    
 
