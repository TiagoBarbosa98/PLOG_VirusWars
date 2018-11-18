/*
 *
* Virus Wars board game coded in SWI-Prolog
*/

virusWars:- menu(Board, Blue, Red), display_game(Board, blue), startGame(Board, Blue, Red, NewBoard), playGame(NewBoard, Blue, Red, NewNewBoard), virusWars.

playerConfig(Blue, Red):- write('Please select game mode: '), nl, write('1. Human vs Human'), nl, write('2. Human vs Computer'), nl, write('3. Computer vs Computer'), nl,
							read(Op), (Op = 1 -> Blue = human, Red = human ; (Op = 2 -> Blue = human, Red = ai; (Op = 3 -> Blue = ai, Red = ai; write('Invalid Input\n'),playerConfig(Blue, Red)))).

boardConfig(Board, TB):- write('Please select board size: '), nl, write('1. 11 x 11'), nl, write('2. 13 x 13'), nl, write('3. 15 x 15'), nl,
						read(Size), boardBySize(Size, TB), (TB = [] -> write('Invalid Input\n'), boardConfig(Board, NTB); boardBySize(Size, Board)).

menu(Board, Blue, Red):- write('\n		VIRUS WARS		'), nl, nl, nl, write('1. Tutorial'), nl, write('2. New Game'), nl, write('3. Exit'), nl, read(Op),
	   					(Op = 3 -> halt; (Op = 2 -> playerConfig(Blue, Red), boardConfig(Board, TB); (Op = 1 -> write('Tutorial Placeholder'), nl, menu(Board, Blue, Red); menu(Board, Blue, Red)))).

boardBySize(1, [[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
				[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
				[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
				[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
				[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
				[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
				[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
				[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
				[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
				[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
				[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ']]).

boardBySize(2, [[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
			    [' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
			    [' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
			    [' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
			    [' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
			    [' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
			    [' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
			    [' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
			    [' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
			    [' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
			    [' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
			    [' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
			    [' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ']]).

boardBySize(3, [[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
				[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
				[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
				[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
				[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
				[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
				[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
				[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
				[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
				[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
				[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
				[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
				[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
				[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
				[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ']]).

boardBySize(X, []):- X \= 1, X \= 2, X \= 3.


alterLine(_, [], _, _).
alterLine(0, [H |T] ,NewChar, TemporaryList, NewBoar):- append(TemporaryList, [NewChar | T], NewBoar), !.
alterLine(Column, [H | T], NewChar, TemporaryList, NewBoar):- Col is Column - 1, append(TemporaryList,  [H], NewTempList), alterLine(Col, T, NewChar, NewTempList, NewBoar).


alterPos(C, 0, [H | T], NewChar, TemporaryList, NewBoar):- alterLine(C, H, NewChar, TmpL, NewLine), append(TemporaryList, [NewLine | T], NewBoar), !.
alterPos(C, L, [H | T], NewChar, TemporaryList, NewBoar):- NewLine is L - 1, append(TemporaryList, [H], NewTempList), alterPos(C, NewLine, T, NewChar, NewTempList, NewBoar).

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

display_game([], _):- write("wkbvweibfwbvi	wbbweibb").
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





getCellPlays(pos(C, L), Player, Board,CM):- (isLive(Player, Board, pos(C,L)) ; isZombieLinked(pos(C, L), Player, Board, [])), getSize(Board, Size), possibleCellMoves(pos(C,L), Player, Board, Size, CM), !.
getCellPlays(pos(C, L), Player, Board,[]):- not(isLive(Player, Board, pos(C, L))) ; not(isZombieLinked(pos(C, L), Player, Board, [])).

getCellsPlays([], _, _, Moves, Moves).
getCellsPlays([H | TCells], Player, Board, TMoves,Moves):- getCellPlays(H, Player, Board, TL), append(TL, TMoves, NTMoves), getCellsPlays(TCells, Player, Board, NTMoves, Moves), !. 


valid_moves(Board, red, ListOfMoves):- getSize(Board, Size), getRedsCells(Board,  Size, 0, [], RedsCells), getCellsPlays(RedsCells, red, Board, [], ListOfMoves), !.
valid_moves(Board, blue, ListOfMoves):- getSize(Board, Size), getBluesCells(Board,  Size, 0, [], RedsCells), getCellsPlays(RedsCells, blue, Board, [], ListOfMoves), !.


move(play(blue, pos(C, L)), Board, Board):- valid_moves(Board, blue, LM), not(member(pos(C,L), LM)), write("\nInvalid Position\n"), !.
move(play(blue, pos(C, L)), Board, NewBoar):- valid_moves(Board, blue, LM), member(pos(C,L), LM), getIndexMatrix(C, L, Board, Elem),
											  (Elem = ' ' -> alterPos(C, L, Board, 'B', [], NewBoar) ; alterPos(C, L, Board, 'b', [], NewBoar)), !.

move(play(red, pos(C, L)), Board, Board):- valid_moves(Board, red, LM), not(member(pos(C,L), LM)), write("\nInvalid Position\n"), !.
move(play(red, pos(C, L)), Board, NewBoar):- valid_moves(Board, red, LM), member(pos(C,L), LM), getIndexMatrix(C, L, Board, Elem),
											  (Elem = ' ' -> alterPos(C, L, Board, 'R', [], NewBoar) ; alterPos(C, L, Board, 'r', [], NewBoar)), !.

game_over(Board, blue):- valid_moves(Board, red, []).
game_over(Board, red):- valid_moves(Board, blue, []).

%end(Board):- game_over(Board, blue) ; game_over()

showValidMoves(Board, Player):- valid_moves(Board, Player, LM), write(LM).

play(C, L, Player,Board, TmpBoard,NewBoard):- write('Column: '), nl, read(C), nl, write('Line: '), nl, read(L), move(play(Player, pos(C, L)), Board, TmpBoard),
											  (Board = TmpBoard -> play(NC, NL, Player, Board, NTmpBoard, NewBoard); move(play(Player, pos(C, L)), Board, NewBoard)).

turn(Board, _, TB, Board, N):- game_over(Board, blue), !.
turn(Board, _, TB, Board, N):- game_over(Board, red), !.
turn(Board, Player, TB, Board, 5).
turn(Board, Player, TB, NewBoard, N):- N \= 5, nl, display_game(Board, Player), nl, write('\n1. Show Possible Moves\n'), write('2. Play'), nl, read(Op),
								   (Op = 1 -> showValidMoves(Board, Player), turn(Board, Player, TB, NewBoard, N); play(C, L, Player, Board, TmpBoard, TB)), 
								   NN is N + 1, turn(TB, Player, NTB, NewBoard, NN).

blue1stMove(Board, C, L, NewBoard):- write('Column'), nl, read(C), write('Line'),nl, read(L), getSize(Board, Size), Middle is Size/2, 
									((C < floor(Middle), C >= 0, L < Size, L >= 0)->alterPos(C, L, Board, 'B', [], NewBoard); write('\nInvalid Position\n'), blue1stMove(Board,NC, NL, NewBoard)). 

red1stMove(Board, C, L, NewBoard):- write('Column'), nl, read(C), write('Line'),nl, read(L), getSize(Board, Size), Middle is Size/2, 
									((C > floor(Middle), C < Size, L < Size, L >= 0)->alterPos(C, L, Board, 'R', [], NewBoard); write('\nInvalid Position\n'), red1stMove(Board,NC, NL, NewBoard)). 

startGame(Board, human, human, NewBoard):- nl, write("Blue pick your starting position, on the left side of the Board"), nl, blue1stMove(Board, CB, LB, TmpBoard), display_game(TmpBoard, red),
										   nl, write("Red pick your starting position, on the left side of the Board"), nl, red1stMove(TmpBoard, CR, LR, NewBoard).

playGame(Board, human, human, NewBoard):- game_over(Board, Player), format("~a wins!", Player), nl, write("Well Played!"), !.
playGame(Board, human, human, NewBoard):- 	turn(Board, blue, TB, TmpBoard, 0), 
											turn(TmpBoard, red, NTB, NewBoard, 0),	
											playGame(NewBoard, human, human, NewNewBoard).






%playGame(Board, human, human, NewBoard):- not(game_over(Board, blue)) , not(game_over(Board, red)), display_game(Board, blue), turn(Board, blue, TB, NB, 0),
%											((game_over(NB, blue) ; game_over(NB, red))-> write('Well played!'); nl, write('Blue acabou'), nl, display_game(NB, red), turn(NB, red, NTB, NewBoard, 0), ((game_over(NB, blue) ; game_over(NB, red)) -> write('Well played!') ; nl, write('Red acabou'), playGame(NewBoard, human, human, NewNewBoard), !)), !.
%playGame(Board, _, _, _):- game_over(Board, red), write("PILASVERMELHAS").
%playGame(Board, _, _, _):- game_over(Board, blue), write("PILASAZUIS").
%playGame(Board, human, human, NewBoard):- (game_over(Board, blue)) ; (game_over(Board, red)), !.

/*
 [[' ',' ',' ','B',' ','R',' ',' ',' ',' ',' '],[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ']]
 */
