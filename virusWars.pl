/*
 *
* Virus Wars board game coded in SWI-Prolog
*/

play:- use_module(library(random)),menu(Board, Blue, Red), display_game(Board, blue), startGame(Board, Blue, Red, NewBoard), playGame(NewBoard, Blue, Red, NewNewBoard), play.

playerConfig(Blue, Red):- write('Please select game mode: '), nl, write('1. Human vs Human'), nl, write('2. Human vs Computer'), nl, write('3. Computer vs Computer'), nl,
							read(Op), (Op = 1 -> Blue = human, Red = human ; (Op = 2 -> Blue = human, aiConfig(Red); (Op = 3 -> aiConfig(Blue, Red); write('Invalid Input\n'),playerConfig(Blue, Red)))).

aiConfig(Red):- write("Select Computer LVL"), nl, write('1. Random'), nl, write('2. Semi-Inteligent'), nl, read(Op),
				(Op = 1 -> Red = ai1; (Op = 2 -> Red = ai2; aiConfig(Red))), !.

aiConfig(Blue, Red):- write("Select Computer LVL"), nl, write('1. Dumb vs Dumb'), nl, write('2. Dumber vs Dumber'), nl, write('3. Dumb vs Dumber'), nl,
					  read(Op), (Op = 1 -> Blue = ai2, Red = ai2; (Op = 2 -> Blue = ai1, Red = ai1; (Op = 3 -> Blue = ai2, Red = ai1; aiConfig(Blue, Red)))), !.

boardConfig(human, Board, TB):- write('Please select board size: '), nl, write('0. 5 x 5'), nl,  write('1. 11 x 11'), nl, write('2. 13 x 13'), nl, write('3. 15 x 15'), nl,
								read(Size), boardBySize(Size, TB), (TB = [] -> write('Invalid Input\n'), boardConfig(Board, NTB); boardBySize(Size, Board)).

boardConfig(ai1, Board, TB):- boardBySize(ai, Board), !.
boardConfig(ai2, Board, TB):- boardBySize(ai2, Board), !.

menu(Board, Blue, Red):- write('\n		VIRUS WARS		'), nl, nl, write('1. Tutorial'), nl, write('2. New Game'), nl, write('3. Exit'), nl, read(Op),
	   					(Op = 3 -> halt;
	   					(Op = 2 -> playerConfig(Blue, Red), boardConfig(Blue, Board, TB); 
	   					(Op = 1 -> writeTutorial, nl, menu(Board, Blue, Red);
	   					menu(Board, Blue, Red)))).


boardBySize(0, [[' ',' ',' ',' ',' ', ' '],
				[' ',' ',' ',' ',' ', ' '],
				[' ',' ',' ',' ',' ', ' '],
				[' ',' ',' ',' ',' ', ' '],
				[' ',' ',' ',' ',' ', ' '],
				[' ',' ',' ',' ',' ', ' ']]).				 

boardBySize(ai, [[' ',' ',' ',' ',' '],
				 [' ',' ',' ',' ',' '],
				 [' ',' ',' ',' ',' '],
				 [' ',' ',' ',' ',' '],
				 [' ',' ',' ',' ',' ']]).

boardBySize(ai2, [[' ',' ',' ',' ',' ', ' ', ' '],
				 [' ',' ',' ',' ',' ', ' ', ' '],
				 [' ',' ',' ',' ',' ', ' ', ' '],
				 [' ',' ',' ',' ',' ', ' ', ' '],
				 [' ',' ',' ',' ',' ', ' ', ' '],
				 [' ',' ',' ',' ',' ', ' ', ' '],
				 [' ',' ',' ',' ',' ', ' ', ' ']]).

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

display_game(Board, Player):- getSize(Board, Size), printColumns(1, Size), nl, drawMatrix(Board, 0, Size), drawHorizontalDivider(0, Size), nl,format("~a \'s turn...", Player), nl,!.

getIndexList(0,[M|_],M):- !.
getIndexList(Index, [_|T], M):- Index > 0, NI is Index-1, getIndexList(NI, T, M).

getIndexMatrix(C, L, Matrix, Elem):- getIndexList(L, Matrix, Row), getIndexList(C, Row, Elem).

member(X, [X|_]).
member(X, [_|T]):- member(X, T).

genPos(L, C, pos(C, L)).

getBluesCellsInRow(LI, Size, Size, LF, LF):- !.
getBluesCellsInRow(LI, Size, C, LT, LF):- getIndexList(C, LI, Elem), (Elem = 'B'), NC is C + 1, append(LT, [C], NLT) ,getBluesCellsInRow(LI, Size, NC, NLT, LF), !.
getBluesCellsInRow(LI, Size, C, LT, LF):- getIndexList(C, LI, Elem), not(Elem = 'B'), NC is C + 1, getBluesCellsInRow(LI, Size, NC, LT, LF), !.


getBluesCells(Board, Size, Size, LF, LF):- !.
getBluesCells(Board, Size, L, LT, LF):- getIndexList(L, Board, Row), getBluesCellsInRow(Row, Size, 0, [], ListC), 
										maplist(genPos(L), ListC, PosL), append(LT, PosL, NLT), NL is L + 1, getBluesCells(Board, Size, NL, NLT, LF), !.


getRedsCellsInRow(LI, Size, Size, LF, LF):- !.
getRedsCellsInRow(LI, Size, C, LT, LF):- getIndexList(C, LI, Elem), (Elem = 'R'), NC is C + 1, append(LT, [C], NLT) ,getRedsCellsInRow(LI, Size, NC, NLT, LF), !.
getRedsCellsInRow(LI, Size, C, LT, LF):- getIndexList(C, LI, Elem), not(Elem = 'R'), NC is C + 1, getRedsCellsInRow(LI, Size, NC, LT, LF), !.

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

/*
isZombieLinked(pos(C, L), Player, Board, CPL):- not(member(pos(C,L), CPL)), append(CPL, [pos(C, L)], NCPL) ,isZombie(Player, C, L, Board), (CL is C - 1, CR is C + 1, LUP is L - 1, LDOWN is L + 1, 
														 genPos(LUP, C, P1), genPos(LDOWN, C, P2), genPos(LUP,  CL, P3), genPos(L, CL, P4), genPos(LDOWN, CL, P5), genPos(LUP, CR, P6), genPos(L, CR, P7), genPos(LDOWN, CR, P8)),
									 					((isLive(Player, Board, P1); isLive(Player, Board, P2); isLive(Player, Board, P3);
									 					isLive(Player, Board, P4); isLive(Player, Board, P5); isLive(Player, Board, P6);
									 					isLive(Player, Board, P7); isLive(Player, Board, P8));
									 					(isZombieLinked(P1, Player, Board, NCPL); isZombieLinked(P2, Player, Board, NCPL); isZombieLinked(P3, Player, Board, NCPL);
									 					isZombieLinked(P4, Player, Board, NCPL); isZombieLinked(P5, Player, Board, NCPL); isZombieLinked(P6, Player, Board, NCPL);
									 					isZombieLinked(P7, Player, Board, NCPL); isZombieLinked(P8, Player, Board, NCPL))), !.

*/

filterZombiePos([], _, _, _,LF, LF):-!.
filterZombiePos([pos(C, L) | T], red, Board, Size, LT, LF):- isZombie(red, C, L, Board), append(LT, [pos(C, L)], NLT), filterZombiePos(T, red, Board, Size, NLT, LF).
filterZombiePos([pos(C, L) | T], red, Board, Size, LT, LF):- not(isZombie(red, C, L, Board)), filterZombiePos(T, red, Board, Size, LT, LF).
filterZombiePos([pos(C, L) | T], blue, Board, Size, LT, LF):- isZombie(blue, C, L, Board), append(LT, [pos(C, L)], NLT), filterZombiePos(T, blue, Board, Size, NLT, LF).
filterZombiePos([pos(C, L) | T], blue, Board, Size, LT, LF):- not(isZombie(blue, C, L, Board)), filterZombiePos(T, blue, Board, Size, LT, LF).

possibleZombieMoves(pos(C, L), Player, Board, Size, CPL, []):- member(pos(C, L), CPL) ; not(isZombie(Player, C, L, Board)), !.
possibleZombieMoves(pos(C, L), Player, Board, Size, CPL, LF):- not(member(pos(C, L), CPL)), append(CPL, [pos(C,L)], NCPL),isZombie(Player, C, L, Board), possibleCellMoves(pos(C, L), Player, Board, Size, TL),
															   (CL is C - 1, CR is C + 1, LUP is L - 1, LDOWN is L + 1, genPos(LUP, C, P1), genPos(LDOWN, C, P2),
															   genPos(LUP,  CL, P3), genPos(L, CL, P4), genPos(LDOWN, CL, P5), genPos(LUP, CR, P6), genPos(L, CR, P7),
															   genPos(LDOWN, CR, P8)), possibleZombieMoves(P1, Player, Board, Size, NCPL, L1), possibleZombieMoves(P2, Player, Board, Size, NCPL, L2),
															   possibleZombieMoves(P3, Player, Board, Size, NCPL, L3), possibleZombieMoves(P4, Player, Board, Size, NCPL, L4),
															   possibleZombieMoves(P5, Player, Board, Size, NCPL, L5),possibleZombieMoves(P6, Player, Board, Size, NCPL, L6),
															   possibleZombieMoves(P7, Player, Board, Size, NCPL, L7), possibleZombieMoves(P8, Player, Board, Size, NCPL, L8),
															   append(TL, L1, LF1), append(LF1, L2, LF2), append(LF2, L3, LF3), append(LF3, L4, LF4) , append(LF4, L5, LF5),
															   append(LF5, L6, LF6), append(LF6, L7, LF7), append(LF7, L8, LF), !.

possibleZLMoves([], _, _, _, LF, LF):- !.
possibleZLMoves([H | T], Player, Board, Size, LT, LF):- possibleZombieMoves(H, Player, Board, Size, [], TT), append(TT, LT, NLT), possibleZLMoves(T, Player, Board, Size, NLT, LF), !.

getCellPlays(pos(C, L), Player, Board,CM):- getSize(Board, Size), possibleCellMoves(pos(C,L), Player, Board, Size, CM), !.

getCellsPlays([], _, _, Moves, Moves):- !.
getCellsPlays([H | TCells], Player, Board, TMoves,Moves):- getCellPlays(H, Player, Board, TL), append(TL, TMoves, NTMoves), genRadius(H, ZL1), getSize(Board, Size),
														   filterZombiePos(ZL1, Player, Board, Size, [], ZL2), possibleZLMoves(ZL2, Player, Board, Size, [], ZMoves),
														   append(ZMoves, NTMoves, NNTMOVES),
														   getCellsPlays(TCells, Player, Board, NNTMOVES, Moves), !. 


valid_moves(Board, red, ListOfMoves):- getSize(Board, Size), getRedsCells(Board,  Size, 0, [], RedsCells), getCellsPlays(RedsCells, red, Board, [], ListOfMoves), !.
valid_moves(Board, blue, ListOfMoves):- getSize(Board, Size), getBluesCells(Board,  Size, 0, [], RedsCells), getCellsPlays(RedsCells, blue, Board, [], ListOfMoves), !.


move(play(blue, pos(C, L)), Board, Board):- valid_moves(Board, blue, LM), not(member(pos(C,L), LM)), write("\nInvalid Position\n").
move(play(blue, pos(C, L)), Board, NewBoar):- valid_moves(Board, blue, LM), member(pos(C,L), LM), getIndexMatrix(C, L, Board, Elem),
											  (Elem = ' ' -> alterPos(C, L, Board, 'B', [], NewBoar) ; alterPos(C, L, Board, 'b', [], NewBoar)), !.

move(play(red, pos(C, L)), Board, Board):- valid_moves(Board, red, LM), not(member(pos(C,L), LM)), write("\nInvalid Position\n").
move(play(red, pos(C, L)), Board, NewBoar):- valid_moves(Board, red, LM), member(pos(C,L), LM), getIndexMatrix(C, L, Board, Elem),
											  (Elem = ' ' -> alterPos(C, L, Board, 'R', [], NewBoar) ; alterPos(C, L, Board, 'r', [], NewBoar)), !.

game_over(Board, blue):- valid_moves(Board, red, []), !.
game_over(Board, red):- valid_moves(Board, blue, []), !.

showValidMoves(Board, Player):- valid_moves(Board, Player, LM), write(LM).

play(C, L, Player,Board, TmpBoard,NewBoard):- write('Column: '), nl, read(C), nl, write('Line: '), nl, read(L), move(play(Player, pos(C, L)), Board, TmpBoard),
											  (Board = TmpBoard -> play(NC, NL, Player, Board, NTmpBoard, NewBoard); move(play(Player, pos(C, L)), Board, NewBoard)).

turn(Board, _, TB, Board, N):- game_over(Board, blue), !.
turn(Board, _, TB, Board, N):- game_over(Board, red), !.
turn(Board, Player, TB, Board, 2).
turn(Board, Player, TB, NewBoard, N):- N \= 2, nl, display_game(Board, Player), nl, write('\n1. Show Possible Moves\n'), write('2. Play'), nl, read(Op),
								   (Op = 1 -> showValidMoves(Board, Player), turn(Board, Player, TB, NewBoard, N), ! ; play(C, L, Player, Board, TmpBoard, TB)), 
								   NN is N + 1, turn(TB, Player, NTB, NewBoard, NN), !.

blue1stMove(Board, C, L, NewBoard):- write('Column'), nl, read(C), write('Line'),nl, read(L), getSize(Board, Size), Middle is Size/2, 
									((C < floor(Middle) - 1, C >= 0, L < Size, L >= 0)->alterPos(C, L, Board, 'B', [], NewBoard); write('\nInvalid Position\n'), blue1stMove(Board,NC, NL, NewBoard)). 

red1stMove(Board, C, L, NewBoard):- write('Column'), nl, read(C), write('Line'),nl, read(L), getSize(Board, Size), Middle is Size/2, 
									((C > ceiling(Middle), C < Size, L < Size, L >= 0)->alterPos(C, L, Board, 'R', [], NewBoard); write('\nInvalid Position\n'), red1stMove(Board,NC, NL, NewBoard)). 

startGame(Board, human, human, NewBoard):- nl, write("Blue pick your starting position, on the left side of the Board"), nl, blue1stMove(Board, CB, LB, TmpBoard), display_game(TmpBoard, red),
										   nl, write("Red pick your starting position, on the left side of the Board"), nl, red1stMove(TmpBoard, CR, LR, NewBoard).
startGame(Board, ai1, ai1, NewBoard):- random1stMove(Board, ai1, blue, NB0), random1stMove(NB0, ai1, red, NewBoard), !.
startGame(Board, human, ai1, NewBoard):- nl, write("Blue pick your starting position, on the left side of the Board"), nl, blue1stMove(Board, CB, LB, TmpBoard), display_game(TmpBoard, red),
										  nl, random1stMove(TmpBoard, ai1, red, NewBoard), !.

startGame(Board, human, ai2, NewBoard):- nl, write("Blue pick your starting position, on the left side of the Board"), nl, blue1stMove(Board, CB, LB, TmpBoard), display_game(TmpBoard, red),
										  nl, random1stMove(TmpBoard, ai1, red, NewBoard), !.
startGame(Board, ai2, ai2, NewBoard):- random1stMove(Board, ai1, blue, NB0), random1stMove(NB0, ai1, red, NewBoard), !.


random1stMove(Board, ai1, blue, NewBoard):- getSize(Board, Size), SupLim is floor(Size/2) - 1, random(0, SupLim, C),  LimSup is Size - 1, random(0, LimSup, L), alterPos(C, L, Board, 'B', [], NewBoard), !.
random1stMove(Board, ai1, red, NewBoard):- getSize(Board, Size), SupLim is ceiling(Size/2), LimSup is Size - 1, random(SupLim, LimSup, C),  random(0, LimSup, L), alterPos(C, L, Board, 'R', [], NewBoard), !.

randomMove(C, L, red, Board, NewBoard):- valid_moves(Board, red, LM), getSize(LM, Moves),  SupLim is Moves - 1,(SupLim >= 1 -> random(0, SupLim, Index); Index is 0), 
											getIndexList(Index, LM, pos(C, L)),  getIndexMatrix(C, L, Board, Elem), (Elem = ' ' -> alterPos(C, L, Board, 'R', [], NewBoard);alterPos(C, L, Board, 'r', [], NewBoard) ), !.
randomMove(C, L, blue, Board, NewBoard):- valid_moves(Board, blue, LM), getSize(LM, Moves),  SupLim is Moves - 1, random(0, SupLim, Index),
											getIndexList(Index, LM, pos(C, L)),  getIndexMatrix(C, L, Board, Elem), (Elem = ' ' -> alterPos(C, L, Board, 'B', [], NewBoard);alterPos(C, L, Board, 'b', [], NewBoard) ), !.


randomTurn(Board, _, Board, N):- game_over(Board, blue), !.
randomTurn(Board, _, Board, N):- game_over(Board, red), !.
randomTurn(Board, Player, Board, 2).
randomTurn(Board, Player, NewBoard, N):- N \= 2, nl,  randomMove(C1, L1, Player, Board, TB), NN is N + 1, randomTurn(TB, Player, NewBoard, NN), !.


randomPlay(Board, ai1, ai1, NewBoard):- game_over(Board, Player), display_game(Board, Player),format("~a wins!", Player), nl, write("Well Played!"), !.
randomPlay(Board, ai1, ai1, NewBoard):- display_game(Board, blue), randomTurn(Board, blue, NB, 0), display_game(Board, red),randomTurn(NB, red, NNB, 0), randomPlay(NNB, ai1, ai1, NNNB), !.

playGame(Board, human, human, NewBoard):-  game_over(Board, Player), display_game(Board, Player),format("~a wins!", Player), nl, write("Well Played!"), !.
playGame(Board, human, human, NewBoard):- 	turn(Board, blue, TB, TmpBoard, 0), 
											turn(TmpBoard, red, NTB, NewBoard, 0),	
											playGame(NewBoard, human, human, NewNewBoard).

playGame(Board, ai1, ai1, NewBoard):- randomPlay(Board, ai1, ai1, NewBoard), !.

playGame(Board, human, ai1, NB):- game_over(Board, Player), display_game(Board, Player),format("~a wins!", Player), nl, write("Well Played!"), !.
playGame(Board, human, ai1, NB):- turn(Board, blue, TB, TmpBoard, 0), randomTurn(TmpBoard, red, NewBoard, 0), playGame(NewBoard, human, ai1, NewNewBoard), !.

playGame(Board, human, ai2,  NB):- game_over(Board, Player), display_game(Board, Player),format("~a wins!", Player), nl, write("Well Played!"), !.
playGame(Board, human, ai2, NB):- turn(Board, blue, TB, TmpBoard, 0), thoughtTurn(TmpBoard, red, NewBoard, 0), playGame(NewBoard, human, ai2, NewNewBoard), !.

playGame(Board, ai2, ai2,  NB):- game_over(Board, Player), display_game(Board, Player),format("~a wins!", Player), nl, write("Well Played!"), !.
playGame(Board, ai2, ai2, NB):- thoughtTurn(Board, blue, TmpBoard, 0), display_game(Board, red), thoughtTurn(TmpBoard, red, NewBoard, 0), display_game(Board, blue), playGame(NewBoard, ai2, ai2, NewNewBoard), !.



thoughtTurn(Board, _, Board, N):- game_over(Board, blue), !.
thoughtTurn(Board, _, Board, N):- game_over(Board, red), !.
thoughtTurn(Board, Player, Board, 2).
thoughtTurn(Board, Player, NewBoard, N):- N \= 2, nl, chose_move(Board, ai2, Player, pos(C, L)), move(play(Player, pos(C,L)), Board, TB), NN is N + 1, thoughtTurn(TB, Player, NewBoard, NN), !.


count_elemL(_, [], N, N).
count_elemL(X, [X | T], TN, N):- NN is TN + 1, count_elemL(X, T, NN, N), !.
count_elemL(X, [H | T], TN, N):- H \= X, count_elemL(X, T, TN, N), !.

count_elemM(_, [], NF, NF).
count_elemM(X, [H | T], NT, NF):- count_elemL(X, H, 0, N), NNT is NT + N, count_elemM(X, T, NNT, NF), !.

value(Board, TestedBoard, Player, 10):- game_over(TestedBoard, Player), !.
value(Board, TestedBoard, red, 0):- game_over(TestedBoard, blue), !.
value(Board, TestedBoard, blue, 0):- game_over(TestedBoard, red), !.
value(Board, TestedBoard, red, 2):- count_elemM('r', TestedBoard, 0, NN), count_elemM('r', Board, 0, N), N < NN, !.
value(Board, TestedBoard, red, 1):- count_elemM('R', TestedBoard, 0, NN), count_elemM('R', Board, 0, N), N < NN, !.
value(Board, TestedBoard, blue, 2):- count_elemM('b', TestedBoard, 0, NN), count_elemM('b', Board, 0, N), N < NN, !.
value(Board, TestedBoard, blue, 1):- count_elemM('B', TestedBoard, 0, NN), count_elemM('B', Board, 0, N), N < NN, !.


maxValueMove([], Board, Player, TV, Move, Move):- !.
maxValueMove([pos(C, L) | T], Board, red, 0, 0, Move):- getIndexMatrix(C, L, Board, Elem), (Elem = ' ' -> alterPos(C, L, Board, 'R', [], NewBoar) ; alterPos(C, L, Board, 'r', [], NewBoar)),
															 value(Board, NewBoard, red,  N), maxValueMove(T, Board, red, N, pos(C, L), Move).
maxValueMove([pos(C, L) | T], Board, red, TV, TM, Move):- getIndexMatrix(C, L, Board, Elem), (Elem = ' ' -> alterPos(C, L, Board, 'R', [], NewBoar) ; alterPos(C, L, Board, 'r', [], NewBoar)),
															 value(Board, NewBoard, red, N), (N > TV -> X is 1; X is 0), (X = 1 -> maxValueMove(T, Board, red, N, pos(C, L), Move) ; maxValueMove(T, Board, red, TV,  TM, Move)), !.

maxValueMove([pos(C, L) | T], Board, blue, 0, 0, Move):- getIndexMatrix(C, L, Board, Elem), (Elem = ' ' -> alterPos(C, L, Board, 'R', [], NewBoar) ; alterPos(C, L, Board, 'r', [], NewBoar)),
															 value(Board, NewBoard, blue,  N), maxValueMove(T, Board, blue, N, pos(C, L), Move).
maxValueMove([pos(C, L) | T], Board, blue, TV, TM, Move):- getIndexMatrix(C, L, Board, Elem), (Elem = ' ' -> alterPos(C, L, Board, 'R', [], NewBoar) ; alterPos(C, L, Board, 'r', [], NewBoar)),
															 value(Board, NewBoard, blue, N), (N > TV -> X is 1; X is 0), (X = 1 -> maxValueMove(T, Board, blue, N, pos(C, L), Move) ; maxValueMove(T, Board, blue, TV,  TM, Move)), !.


chose_move(Board, ai1, Player, Move):- valid_moves(Board, Player, LM), getSize(LM, Moves),  SupLim is Moves - 1, random(0, SupLim, Index), getIndexList(Index, LM, Move), !.
chose_move(Board, ai2, Player, Move):- valid_moves(Board, Player, LM), maxValueMove(LM, Board, Player, 0, 0, Move), !.


%[['R', 'R','R', 'b', 'R'],['r','r','r','r','b'],['r','r','r','r','b'], ['r','r','r','B','B'], ['r','r','B','r','B']]

%[[' ',' ','r','B','r','r','r','R','b','b','R'],['B','B','r','B','r','r','r','r','b','b','b'],['B','B','B', 'r','r','r', 'r', 'b','b', 'b', 'R'], ['B','B','B','r', 'r', 'r', 'r', 'b','b','R','R'], ['B', 'B', 'B','B', 'r','r','b','r','b','b','b'], ['B','B','B','B','r','r','b','b','b','b','b'], ['B','B','B','B','r','B','b','b','b','b','b'],['B','B','B','B','b','R','b','b','b','b','r'], [' ',' ','R','R','R','R','R','R','b','R','b'], [' ', 'R','R','R','R','R','R','R','R','b','b'], [' ',' ',' ', 'R','R','R','R', 'b','b','R','R']]

%playGame(Board, human, human, NewBoard):- not(game_over(Board, blue)) , not(game_over(Board, red)), display_game(Board, blue), turn(Board, blue, TB, NB, 0),
%											((game_over(NB, blue) ; game_over(NB, red))-> write('Well played!'); nl, write('Blue acabou'), nl, display_game(NB, red), turn(NB, red, NTB, NewBoard, 0), ((game_over(NB, blue) ; game_over(NB, red)) -> write('Well played!') ; nl, write('Red acabou'), playGame(NewBoard, human, human, NewNewBoard), !)), !.
%playGame(Board, _, _, _):- game_over(Board, red), write("PILASVERMELHAS").
%playGame(Board, _, _, _):- game_over(Board, blue), write("PILASAZUIS").
%playGame(Board, human, human, NewBoard):- (game_over(Board, blue)) ; (game_over(Board, red)), !.

/*
 [[' ',' ',' ','B',' ','R',' ',' ',' ',' ',' '],[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],[' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ']]
 

 */


writeTutorial:- write('Virus Wars is a 2 player strategy game The objective for each player is to control the board and leave the opponent with no valid plays.'),
			nl, nl, write('Each player has a virus colony, every move, the colony can grow further by adding another virus to the board, or by absorbing an opponent’s virus, making the piece a zombie.'),
			nl, nl, write('The colors of the pieces available are blue and red. Whoever has the blue pieces always starts the game by placing a blue virus on the left side of the board. \n\nThere are 4 different piece types in Virus Wars: the blue virus and the red virus, the blue zombie and the red zombie.'),
			nl, nl, write('The rules for each play are as follows (note that every play must be done adjacently to a virus of the person making the play already on the board or adjacently to a zombie which it’s connected to virus or adjacently to a zombie which it’s connected to another zombie connected to a virus, and so on):'),
			nl, write('\tA generation is executed when you place a new virus on an empty square of the board;\n\tAn absorption is executed when you consume an opponent’s virus, replacing it with a permanent zombie (zombies cannot be consumed);'),
			nl, nl, write('A player’s turn ends after 5 mandatory plays. Therefore, an example of a possible turn would be 4 generations followed by 1 absorption of a now adjacent opponent’s virus.'),
			nl, nl, write('A player is declared the winner when the opponent cannot complete a turn, due to having no 5 valid plays to make in a row.\n\n').
