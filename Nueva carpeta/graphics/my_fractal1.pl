

:- use_module(library(pce)).



draw_square(N, X, Y, Len) :-
  new(Window, picture('My window')),
  send(Window, size, size(400,400)),
  send(Window, open),  
  my_fractal(Window, N, point(X,Y), Len).
  
  
  
my_fractal(Window, 1, point(X,Y), Len) :-
  X1 is X + Len,
  Y1 is Y - Len,
  
  send(Window, display, new(Pa, path)),
        (
	      send(Pa, append, point(X, Y)),
	      send(Pa, append, point(X, Y1)),
	      send(Pa, append, point(X1, Y1)),
		  send(Pa, append, point(X1, Y)),
	      send(Pa, closed, @on)	      
	   ).
    
  
  
my_fractal(Window, N, point(X,Y), Len):- 
 X1 is X + Len,
 Y1 is Y - Len,
 
 send(Window, display, new(Pa, path)),
        (
	      send(Pa, append, point(X, Y)),
	      send(Pa, append, point(X, Y1)),
	      send(Pa, append, point(X1, Y1)),
		  send(Pa, append, point(X1, Y)),
	      send(Pa, closed, @on)	      
	   ),

 N2 is N-1,
 X1 is X + (Len div 4) - (Len div 8),
 Y1 is Y - (Len div 4) + (Len div 8),
 Len2 is Len div 4,
 my_fractal(Window, N2, point(X1, Y1), Len2).
 
 

  
  
  