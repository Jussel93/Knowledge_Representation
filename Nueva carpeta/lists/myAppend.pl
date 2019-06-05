
% myAppend(+List1, +List2, -Result) 
% it is true if Result is a list with
% the elements of List1 followed by
% the elementos of List2.

myAppend([], List2, List2).

myAppend([Head|Tail], List2, [Head|R]):-
  myAppend(Tail, List2, R).