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
drawLine(Size):- write("-----"), NS is Size - 1, drawLine(NS).

drawFirstLine(Size, Size).
drawFirstLine(Size, 0):- write("    A   "), drawFirstLine(Size, 1).
drawFirstLine(Size, N):- N \= Size, C is 65 + N,format("~c   ", C), NN is N + 1,  drawFirstLine(Size, NN).

showBoard([], red, _, Size):- nl, drawLine(Size), nl,write("Red's turn...").
showBoard([], blue, _, _):- nl, write("Blue's turn...").
showBoard([pos(a, _, C)|TailBoard], _, L, Size):- nl, drawLine(Size) ,nl, format("~d |", L), put(' '), put(C),put(' ') ,write("|"), LT is L + 1 ,showBoard(TailBoard, _,LT, Size).
showBoard([pos(X, _, C)|T], _, L, Size):- X \= a,  write(" "), put(C),put(' ') ,write("|"), showBoard(T, _, L, Size).

getSize([pos(_, Y, _)], Y).
getSize([_|T], N):- getSize(T, N).

display_game( Board, Player):- getSize(Board, Size), drawFirstLine(Size, 0), showBoard(Board, Player, 0, Size).
% 	a b c d
% 1
% 2
% 3
%TEST LIST: [pos(a, 1, '*'), pos(b, 1, '*'), pos(c, 1, '*'), pos(a, 2, ' '),pos(b, 2, ' '), pos(c, 2, '-'), pos(a, 3, '*'), pos(b, 3, ' '), pos(c, 3, '-')].
%[pos(a, 1, '*'), pos(b, 1, '*'), pos(c, 1, '*'), pos(a, 2, ' '),pos(b, 2, ' '), pos(c, 2, '-'), pos(a, 3, '*'), pos(b, 3, ' '), pos(c, 3, '-')].