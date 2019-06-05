

:- use_module(library(pce)).

window_size(400, 400).

draw_square :-
  window_size(MaxX, MaxY),
  new(Window, picture('My window')),
  send(Window, size, size(MaxX, MaxY)),
  send(Window, open),
  draw_lines(Window), 
  MX1 is (MaxX div 2 + 59), MY1 is (MaxY div 2 - 20), % 20 space over the middle
  draw_cannibal(Window, MX1, MY1), 
  MX2 is (MaxX div 2 + 109), MY2 is MY1,
  draw_cannibal(Window, MX2, MY2), 
  MX3 is (MaxX div 2 + 159), MY3 is MY1,
  draw_cannibal(Window, MX3, MY3), 
  CX1 is MX1, CY1 is (MaxY div 2 + 52), % 20 space + 32 picture Y size
  draw_angel(Window, CX1, CY1), 
  CX2 is MX2, CY2 is CY1,
  draw_angel(Window, CX2, CY2), 
  CX3 is MX3, CY3 is CY1,
  draw_angel(Window, CX3, CY3).
  
  
  
draw_lines(Window):- 
  window_size(MaxX, MaxY),
  X11 is (MaxX div 2 + 50),
  Y11 is MaxY,
  X12 is X11, Y12 is 0,
  send(Window, display, new(Pa, path)),
        (
	      send(Pa, append, point(X11, Y11)),
          send(Pa, append, point(X12, Y12))
		),
  X21 is (MaxX div 2 - 50), Y21 is MaxY,
  X22 is X21, Y22 is 0,  
  send(Window, display, new(Pa2, path)),
        (
	      send(Pa2, append, point(X21, Y21)),
          send(Pa2, append, point(X22, Y22))
		).
		
  draw_book(Window, X, Y):-
    send(Window, display,
          new(BitMap, bitmap('32x32/book.xpm')), point(X, Y)),
		  sleep(1).
		  
draw_cannibal(Window, X, Y):-
    send(Window, display,
          new(BitMap, bitmap('32x32/cannibal.xpm')), point(X, Y)),
		  sleep(1).
		  
draw_angel(Window, X, Y):-
    send(Window, display,
          new(BitMap, bitmap('32x32/angel.xpm')), point(X, Y)),
		  sleep(1).
   
  
  