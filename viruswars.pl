/*
* Virus Wars board game coded in SWI-Prolog
*/

virusWars:-
			write('Please select board size: '), nl, write('1. 11 x 11'), nl, write('2. 13 x 13'), nl, write('3. 15 x 15'), nl,
			read(Size).


%[pos(1, 1, ' '), pos(1, 2, ' ')]
alterpos(X, Y, [pos(X, Y,_) | T], LT, LF):- append(LT, [pos(X, Y, '*')|T], LF). 
alterpos(X, Y, [H | T], LT, LF):- 	append(LT, [H] , NLT),
									alterpos(X, Y, T, NLT, LF).