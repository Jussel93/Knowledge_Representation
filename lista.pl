% reverse (+List, -Result)
% it is true if  Result unify with a list
% with the same elements that List have but
% in reverse order
%
% ? reverse ([1,2,3,4], R).
% [4,3,2,1]

myReverse([], []).

myReverse([Head|Tail],R2):- myReverse(Tail, R), 
	append(R,[Head],R2).

% myReverse ([1,2,3,4],  ):-myReverse([2,3,4], [4,3,2]),

% append([1,2,3], [4,5,6], R).
% R=[1,2,3,4,5,6]


append([], L, L).
append([Head|Tail], List2, [Head|R]):-
   append(Tail,List2,R).
   

sort_bubble(List, List):- sort(List).
sort_bubble(List, RT):- 
	append(Ini, [E1,E2|End], List), 
	E1>E2,
	append(Ini, [E2,E1|End], R),
	order_bubble(R, RT).  

sort([]).
sort([_]).
sort([Cab1, Cab2|Rest]):-
	Cab1 =< Cab2,
	sort([Cab2|Rest]).
	 
	 


insert_in_list_sort(Elem, [], [Elem]).
insert_in_list_sort(Elem, [Head|Tail], [Elem, Head|Tail]):-
   Elem =< Head.
insert_in_list_sort(Elem, [Head|Tail], [Head|R]):-
   Elem > Head,
 insert_in_list_sort(Elem, Tail, R).
 
 
sort_incertion([],[]).
sort_incertion([Head|Tail], RT):-
   sort_incertion(Tail, R),
   insert_in_list_sort(Head,R, RT).
   
   
% divide(+Elem, +List, -Lower, -Higher)
% it is true if Lower is a list with the elements of List that are lower than Elem
% and Higher is a list with elements of List that are higher than Elem    
% Es wird ein Element E vorgegeben, welches die gesamte Liste in zwei Teile teilt,
% einen Teil mit niedrigeren und gleichen Nummbern und einen Teil mit groesseren Nummbern
   
divide(_,[],[],[]).
divide(Elem, [Head|Tail], Lower, [Head|Higher]):-
  Head > Elem,
  divide(Elem, Tail, Lower, Higher).
divide(Elem, [Head|Tail], [Head|Lower], Higher):-
  Head =< Elem,
  divide(Elem, Tail, Lower, Higher). 

% divide(5, [1,9,2,8,3,7,4,6,5], L, H). --> Es wird das Element 5 als Element festgelegt, welche die Liste in zwei Teile teilt
% L = [1, 2, 3, 4, 5],  --> Liste mit Elementen kleiner gleich 5
% H = [9, 8, 7, 6]   --> Liste mit Elementen groesser 5

   
sort_quick([],[]).
sort_quick([Head|Tail], R):-
divide(Head, Tail, Low, High),
  sort_quick(Low, RLow),  
  sort_quick(High, RHigh),
  append(RLow, [Head|RHigh], R).   
  
% RMen  --> sorted list with lower numbers
% RHigh --> sorted list with higher numbers
  
  
  
  
list_dividers(_, 1, [1]).
list_dividers(X, Y, [Y|R]):-
  Y > 1,
  Y2 is Y-1,
  list_dividers(X,Y2, R),
  0 is X mod Y.
list_dividers(X, Y, R):-
  Y > 1,
  Y2 is Y-1,
  list_dividers(X,Y2, R),
  Z is X mod Y, Z \== 0.


primo(X):- list_dividers(X,X,[X,1]). 


primosEntrexy(X,X,[]).
primosEntrexy(X,Y, [X|R]):- X<Y,
  X2 is X+1,
  primosEntrexy(X2,Y, R),
  primo(X).
primosEntrexy(X,Y, R):- X<Y,
  X2 is X+1,
  primosEntrexy(X2,Y, R),
  \+ primo(X).


  
  
   