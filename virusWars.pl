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
printColumns(Size, Size):- C is Size - 1, format("   ~d  ", C).
printColumns(1, Size):- write("    0"), printColumns(2, Size).
printColumns(Count, Size):- C is Count - 1, format("   ~d", C), NC is Count + 1, printColumns(NC, Size).

drawLine([]).
drawLine([H]):- printCell(H), write(" |").
drawLine([H|T]):- printCell(H), drawLine(T).

drawMatrix([], _, _).
drawMatrix([H|T], L, Size):- drawHorizontalDivider(0, Size), nl, (L < 10 -> format("~d ", L); format("~d", L)), NL is L + 1, drawLine(H), nl, drawMatrix(T, NL, Size).

display_game(Board, Player):- getSize(Board, Size), printColumns(1, Size), nl, drawMatrix(Board, 0, Size), drawHorizontalDivider(0, Size), nl,format("~a \'s turn...", Player), !.

getIndexList(0,[M|_],M):- !.
getIndexList(Index, [_|T], M):- Index > 0, NI is Index-1, getIndexList(NI, T, M).

getIndexMatrix(C, L, Matrix, Elem):- getIndexList(L, Matrix, Row), getIndexList(C, Row, Elem).

member(X, [X|_]).
member(X, [_|T]):- member(X, T).

genPos(L, C, pos(C, L)).

getBluesCellsInRow(LI, Size, Size, LF, LF):- !.
getBluesCellsInRow(LI, Size, C, LT, LF):- getIndexList(C, LI, Elem), (Elem = 'B' ; Elem = 'b'), NC is C + 1, append(LT, [C], NLT) ,getBluesCellsInRow(LI, Size, NC, NLT, LF), !.
getBluesCellsInRow(LI, Size, C, LT, LF):- getIndexList(C, LI, Elem), not(Elem = 'B' ; Elem = 'b'), NC is C + 1, getBluesCellsInRow(LI, Size, NC, LT, LF), !.


getBluesCells(Board, Size, Size, LF, LF):- !.
getBluesCells(Board, Size, L, LT, LF):- getIndexList(L, Board, Row), getBluesCellsInRow(Row, Size, 0, [], ListC), 
										maplist(genPos(L), ListC, PosL), append(LT, PosL, NLT), NL is L + 1, getBluesCells(Board, Size, NL, NLT, LF), !.


getRedsCellsInRow(LI, Size, Size, LF, LF):- !.
getRedsCellsInRow(LI, Size, C, LT, LF):- getIndexList(C, LI, Elem), (Elem = 'R' ; Elem = 'r'), NC is C + 1, append(LT, [C], NLT) ,getRedsCellsInRow(LI, Size, NC, NLT, LF), !.
getRedsCellsInRow(LI, Size, C, LT, LF):- getIndexList(C, LI, Elem), not(Elem = 'R' ; Elem = 'r'), NC is C + 1, getRedsCellsInRow(LI, Size, NC, LT, LF), !.

getRedsCells(Board, Size, Size, LF, LF):- !.
getRedsCells(Board, Size, L, LT, LF):- getIndexList(L, Board, Row), getRedsCellsInRow(Row, Size, 0, [], ListC), 
										maplist(genPos(L), ListC, PosL), append(LT, PosL, NLT), NL is L + 1, getRedsCells(Board, Size, NL, NLT, LF), !.

isRealPos(pos(C, L), Size):- C >= 0, C < Size, L >= 0, L < Size.

isValidPos(pos(C, L), Size, Board, red):- isRealPos(pos(C, L), Size), getIndexMatrix(C, L, Board, Elem), (Elem = 'B' ; Elem = ' '), !.
isValidPos(pos(C, L), Size, Board, blue):- isRealPos(pos(C, L), Size), getIndexMatrix(C, L, Board, Elem), (Elem = 'R' ; Elem = ' '), !.

genRadius(pos(C, L), List):- CL is C - 1, CR is C + 1, LUP is L - 1, LDOWN is L + 1, 
							 List = [pos(C, LUP), pos(C, LDOWN), pos(CL, LUP), pos(CL, L), pos(CL, LDOWN), pos(CR, LUP), pos(CR, L), pos(CR,LDOWN)].

filterValidPos([], _, _, _,LF, LF):-!.
filterValidPos([H | T], red, Board, Size, LT, LF):- isValidPos(H, Size, Board, red), append(LT, [H], NLT), filterValidPos(T, red, Board, Size, NLT, LF), !.
filterValidPos([H | T], red, Board, Size, LT, LF):- not(isValidPos(H, Size, Board, red)), filterValidPos(T, red, Board, Size, LT, LF), !.
filterValidPos([H | T], blue, Board, Size, LT, LF):- isValidPos(H, Size, Board, blue), append(LT, [H], NLT), filterValidPos(T, blue, Board, Size, NLT, LF), !.
filterValidPos([H | T], blue, Board, Size, LT, LF):- not(isValidPos(H, Size, Board, blue)), filterValidPos(T, blue, Board, Size, LT, LF), !.

possibleCellMoves(pos(C, L), Player, Board, Size, LF):- genRadius(pos(C, L), Poss1), filterValidPos(Poss1, Player, Board, Size, [], LF), !.

isLive(red, Board, pos(C, L)):- getSize(Board, Size), isRealPos(pos(C, L), Size), getIndexMatrix(C, L, Board, 'R'), !.
isLive(blue, Board, pos(C, L)):- getSize(Board, Size), isRealPos(pos(C, L), Size), getIndexMatrix(C, L, Board, 'B'), !.

isZombie(red, C, L, Board):- getSize(Board, Size), isRealPos(pos(C, L), Size), getIndexMatrix(C, L, Board, 'r'), !.
isZombie(blue, C, L, Board):-  getSize(Board, Size), isRealPos(pos(C, L), Size), getIndexMatrix(C, L, Board, 'b'), !.

isZombieLinked(pos(C, L), Player, Board, CPL):- not(member(pos(C,L), CPL)), append(CPL, [pos(C, L)], NCPL) ,isZombie(Player, C, L, Board), (CL is C - 1, CR is C + 1, LUP is L - 1, LDOWN is L + 1, 
														 genPos(LUP, C, P1), genPos(LDOWN, C, P2), genPos(LUP,  CL, P3), genPos(L, CL, P4), genPos(LDOWN, CL, P5), genPos(LUP, CR, P6), genPos(L, CR, P7), genPos(LDOWN, CR, P8)),
									 					((isLive(Player, Board, P1); isLive(Player, Board, P2); isLive(Player, Board, P3);
									 					isLive(Player, Board, P4); isLive(Player, Board, P5); isLive(Player, Board, P6);
									 					isLive(Player, Board, P7); isLive(Player, Board, P8));
									 					(isZombieLinked(P1, Player, Board, NCPL); isZombieLinked(P2, Player, Board, NCPL); isZombieLinked(P3, Player, Board, NCPL);
									 					isZombieLinked(P4, Player, Board, NCPL); isZombieLinked(P5, Player, Board, NCPL); isZombieLinked(P6, Player, Board, NCPL);
									 					isZombieLinked(P7, Player, Board, NCPL); isZombieLinked(P8, Player, Board, NCPL))), !.





getCellPlays(pos(C, L), Player, Board,CM):- (isLive(Player, Board, pos(C,L)) ; isZombieLinked(pos(C, L), Player, Board, [])), getSize(Board, Size), possibleCellMoves(pos(C,L), Player, Board, Size, CM).

getCellsPlays([], _, _, Moves, Moves).
getCellsPlays([H | TCells], Player, Board, TMoves,Moves):- getCellPlays(H, Player, Board, TL), append(TL, TMoves, NTMoves), getCellsPlays(TCells, Player, Board, NTMoves, Moves), !. 


valid_moves(Board, red, ListOfMoves):- getSize(Board, Size), getRedsCells(Board,  Size, 0, [], RedsCells), getCellsPlays(RedsCells, red, Board, [], ListOfMoves), write(ListOfMoves), !.
valid_moves(Board, blue, ListOfMoves):- getSize(Board, Size), getBluesCells(Board,  Size, 0, [], RedsCells), getCellsPlays(RedsCells, blue, Board, [], ListOfMoves), write(ListOfMoves), !.

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