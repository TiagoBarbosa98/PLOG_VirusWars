/*
 *
* Virus Wars board game coded in SWI-Prolog
*/

virusWars:-
			write('Please select board size: '), nl, write('1. 11 x 11'), nl, write('2. 13 x 13'), nl, write('3. 15 x 15'), nl,
			read(Size),
			write(Size).

alterCol(_, [], _, _).
alterCol(0, [H |T] ,NewChar, TemporaryList, NewBoar):- append(TemporaryList, [NewChar | T], NewBoar).
alterCol(Column, [H | T], NewChar, TemporaryList, NewBoar):- Col is Column - 1, append(TemporaryList,  [H], NewTempList), alterCol(Col, T, NewChar, NewTempList, NewBoar).


alterPos(0, Y, [H | T], NewChar, TemporaryList, NewBoar):- alterCol(Y, H, NewChar, TmpL, NewCol), append(TemporaryList, [NewCol | T], NewBoar).
alterPos(X, Y, [H | T], NewChar, TemporaryList, NewBoar):- NewLine is X - 1, append(TemporaryList, [H], NewTempList), alterPos(NewLine, Y, T, NewChar, NewTempList, NewBoar).

getSize([], 0).
getSize([H | T], Size):- getSize(T, NS), Size is 1 + NS.

printCell(H):- format("| ~a ", H).

drawHorizontalDivider(Size, Size):- write("-").
drawHorizontalDivider(0, Size):- write("  -----"), drawHorizontalDivider(1, Size).
drawHorizontalDivider(Count, Size):- NC is Count + 1, write("----"), drawHorizontalDivider(NC, Size).

printColumns(_, 0).
printColumns(Size, Size):- C is Size + 64, format("   ~c  ", C).
printColumns(1, Size):- write("    A"), printColumns(2, Size).
printColumns(Count, Size):- C is Count + 64, format("   ~c", C), NC is Count + 1, printColumns(NC, Size).

drawLine([]).
drawLine([H]):- printCell(H), write(" |").
drawLine([H|T]):- printCell(H), drawLine(T).

drawMatrix([], _, _).
drawMatrix([H|T], L, Size):- drawHorizontalDivider(0, Size), nl, (L < 10 -> format("~d ", L); format("~d", L)), NL is L + 1, drawLine(H), nl, drawMatrix(T, NL, Size).

display_game(Board, Player):- getSize(Board, Size), printColumns(1, Size), nl, drawMatrix(Board, 0, Size), drawHorizontalDivider(0, Size), nl,format("~a \'s turn...", Player).



%valid_moves(+Board, +Player, -ListOfMoves).
/*
 [[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
  [' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
  [' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
  [' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
  [' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
  [' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
  [' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
  [' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
  [' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
  [' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
  [' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ']]
 */