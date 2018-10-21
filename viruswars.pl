/*
 *
* Virus Wars board game coded in SWI-Prolog
*/

virusWars:-
			write('Please select board size: '), nl, write('1. 11 x 11'), nl, write('2. 13 x 13'), nl, write('3. 15 x 15'), nl,
			read(Size),
			write(Size).


%[pos(a, 1, ' '), pos(b, 1, ' ')]
% Alter pos(X, Y, _), LT --> Temporary List, LF --> Final List, C --> New Char
alterpos(X, Y, [pos(X, Y,_) | T], LT, LF, C):- append(LT, [pos(X, Y, C)|T], LF). 
alterpos(X, Y, [H | T], LT, LF, C):- 	append(LT, [H] , NLT),
									alterpos(X, Y, T, NLT, LF, C).

drawLine(0).
drawLine(Size):- write("------------------------------------------------").%, NS is Size - 1, drawLine(NS).

drawFirstLine(Size, Size).
drawFirstLine(Size, 0):- write("    A   "), drawFirstLine(Size, 1).
drawFirstLine(Size, N):- N \= Size, C is 65 + N,format("~c   ", C), NN is N + 1,  drawFirstLine(Size, NN).

showBoard([], red, _, Size):- nl, drawLine(Size), nl,write("Red's turn...").
showBoard([], blue, _, _):- nl, write("Blue's turn...").
showBoard([pos(a, _, C)|TailBoard], _, L, Size):- nl, drawLine(Size),
												  nl, (L < 10 ->  format("~d  |", L) ;  format("~d |", L)),
												  put(' '), put(C), put(' '), write("|"), LT is L + 1,
												  showBoard(TailBoard, _,LT, Size).
showBoard([pos(X, _, C)|T], _, L, Size):- X \= a,  write(" "), put(C), put(' ') ,write("|"), showBoard(T, _, L, Size).

getSize([pos(_, Y, _)], Y).
getSize([_|T], N):- getSize(T, N).

display_game(Board, Player):- getSize(Board, Size), drawFirstLine(Size, 0), showBoard(Board, Player, 1, Size).
% 	a b c d
% 1
% 2
% 3
%TEST LIST: [pos(a, 1, 'R'), pos(b, 1, 'B'), pos(c, 1, 'r'), pos(a, 2, ' '),pos(b, 2, ' '), pos(c, 2, 'b'), pos(a, 3, '*'), pos(b, 3, ' '), pos(c, 3, '-')].
%[pos(a, 1, '*'), pos(b, 1, '*'), pos(c, 1, '*'), pos(a, 2, ' '),pos(b, 2, ' '), pos(c, 2, '-'), pos(a, 3, '*'), pos(b, 3, ' '), pos(c, 3, '-')].

/*[pos(a, 1, 'R'), pos(b, 1, 'B'), pos(c, 1, 'r'), pos(d, 1, 'R'), pos(e, 1, 'B'), pos(f, 1, 'r'), pos(g, 1, 'R'), pos(h, 1, 'B'), pos(i, 1, 'r'), pos(j, 1, 'R'), pos(k, 1, 'B'),
pos(a, 2, 'R'), pos(b, 2, 'R'), pos(c, 2, 'r'), pos(d, 2, 'R'), pos(e, 2, 'B'), pos(f, 2, 'r'), pos(g, 2, 'R'), pos(h, 2, 'B'), pos(i, 2, 'B'), pos(j, 2, 'B'), pos(k, 2, 'B'),
pos(a, 3, 'R'), pos(b, 3, 'B'), pos(c, 3, 'r'), pos(d, 3, ' '), pos(e, 3, 'r'), pos(f, 3, 'r'), pos(g, 3, 'b'), pos(h, 3, ' '), pos(i, 3, 'b'), pos(j, 3, ' '), pos(k, 3, 'b'),
pos(a, 4, ' '), pos(b, 4, ' '), pos(c, 4, ' '), pos(d, 4, 'R'), pos(e, 4, 'B'), pos(f, 4, ' '), pos(g, 4, 'b'), pos(h, 4, 'R'), pos(i, 4, 'R'), pos(j, 4, ' '), pos(k, 4, ' '),
pos(a, 5, ' '), pos(b, 5, 'B'), pos(c, 5, ' '), pos(d, 5, ' '), pos(e, 5, 'B'), pos(f, 5, 'r'), pos(g, 5, 'r'), pos(h, 5, 'B'), pos(i, 5, 'r'), pos(j, 5, 'R'), pos(k, 5, ' '),
pos(a, 6, ' '), pos(b, 6, 'b'), pos(c, 6, ' '), pos(d, 6, ' '), pos(e, 6, ' '), pos(f, 6, ' '), pos(g, 6, 'R'), pos(h, 6, ' '), pos(i, 6, 'R'), pos(j, 6, 'B'), pos(k, 6, ' '),
pos(a, 7, ' '), pos(b, 7, ' '), pos(c, 7, 'B'), pos(d, 7, 'R'), pos(e, 7, ' '), pos(f, 7, 'r'), pos(g, 7, ' '), pos(h, 7, 'B'), pos(i, 7, 'r'), pos(j, 7, 'R'), pos(k, 7, ' '),
pos(a, 8, ' '), pos(b, 8, ' '), pos(c, 8, 'b'), pos(d, 8, 'r'), pos(e, 8, 'b'), pos(f, 8, ' '), pos(g, 8, ' '), pos(h, 8, 'r'), pos(i, 8, ' '), pos(j, 8, 'R'), pos(k, 8, 'B'),
pos(a, 9, 'B'), pos(b, 9, ' '), pos(c, 9, 'R'), pos(d, 9, 'r'), pos(e, 9, 'B'), pos(f, 9, ' '), pos(g, 9, 'R'), pos(h, 9, 'B'), pos(i, 9, ' '), pos(j, 9, ' '), pos(k, 9, 'B'),
pos(a, 10, 'B'), pos(b, 10, 'B'), pos(c, 10, 'r'), pos(d, 10, 'R'), pos(e, 10, 'B'), pos(f, 10, 'r'), pos(g, 10, 'R'), pos(h, 10, 'B'), pos(i, 10, ' '), pos(j, 10, ' '), pos(k, 10, 'b'),
pos(a, 11, 'R'), pos(b, 11, 'b'), pos(c, 11, 'r'), pos(d, 11, ' '), pos(e, 11, ' '), pos(f, 11, 'R'), pos(g, 11, 'r'), pos(h, 11, 'B'), pos(i, 11, 'r'), pos(j, 11, 'R'), pos(k, 11, 'B')]
*/