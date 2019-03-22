% myLength(List, Result)
% is true if Result unify with the length of List

myLength([], 0).

% if myLength(n-1) -> myLength(n)

% | -> [Head|Tail]=[1,2,3,4,5].
% Head = [1],
% Tail = [2,3,4,5].

% if myLength(n-1) -> myLength(n)

%myLength([Head|Tail], ):-myLength(Tail,Result).
%----------------------	 ---------------------
%	P(n)		<-	P(n-1)
% Das Ergebnis ist das "Result" enthaelt die Laenge der Liste "Tail" 
% --> Es fragt immer nach der Laenge der Liste welche vor Result steht!!!

myLength([_|Tail], Result2) :-
myLength(Tail,Result), Result2 is Result + 1.

