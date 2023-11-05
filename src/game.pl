
run_game(pvp, _Board, X, Y) :-
    Y \= 2,
    display_game(_Board),
    repeat,
    (
       write('Enter column: '),
       read_column(ColumnString),
       column(ColumnString, Column),
       write('Enter row: '),
       read_row(RowString),
       row(RowString, Row),
       (
          validate_move(_Board, Column, Row) ->
          move(_Board, Row, Column, X, NewBoard),
          write('\n'),
          game_over(pvp, NewBoard, X, Y); 
          write('Invalid move, please try again.'), nl,
          fail
        )
     ).

run_game(pvp, _Board, X, 2) :-
    display_game(_Board),
    write('Pie Rule (y/n): '),
    read_pie_rule(Rule),
    pie_rule(Rule, pvp, _Board, X).

game_over(pvp, NewBoard, X, Y) :-
    countCells(NewBoard, X, Count),
    length(NewBoard, XMax),
    nth1(1, NewBoard, Temp),
    length(Temp, YMax),
    nrPieces(XMax, YMax, Expected),
    Count = Expected,
    display_game(NewBoard),
    write('The '),
    write(X),
    write(' has won\n').

game_over(pvp, NewBoard, X, Y) :-
    countCells(NewBoard, X, Count),
    length(NewBoard, XMax),
    nth1(1, NewBoard, Temp),
    length(Temp, YMax),
    nrPieces(XMax, YMax, Expected),
    Count \= Expected,
    Game2 is Y + 1,
    changeColor(X, NewX),
    run_game(pvp, NewBoard, NewX, Game2).


game_over(pvc, Board, Level, X, Y) :-
    countCells(Board, X, Count),
    length(Board, XMax),
    nth1(1, Board, Temp),
    length(Temp, YMax),
    nrPieces(XMax, YMax, Expected),
    Count = Expected,
    display_game(Board),
    write('The '),
    write(X),
    write(' has won\n').

game_over(pvc, Board, Level, X, Y) :-
    countCells(Board, X, Count),
    length(Board, XMax),
    nth1(1, Board, Temp),
    length(Temp, YMax),
    nrPieces(XMax, YMax, Expected),
    Count < Expected,
    Game2 is Y + 1,
    changeColor(X, NewX),
    run_game(pvc, Board, Level, NewX, Game2).

game_over(cvc, Board, Level1, Level2, X, Y) :-
    countCells(Board, X, Count),
    length(Board, XMax),
    nth1(1, Board, Temp),
    length(Temp, YMax),
    nrPieces(XMax, YMax, Expected),
    Count = Expected,
    display_game(Board),
    write('The '),
    write(X),
    write(' has won\n').

game_over(cvc, Board, Level1, Level2, X, Y) :-
    countCells(Board, X, Count),
    length(Board, XMax),
    nth1(1, Board, Temp),
    length(Temp, YMax),
    nrPieces(XMax, YMax, Expected),
    Count < Expected,
    Game2 is Y + 1,
    changeColor(X, NewX),
    run_game(cvc, Board, Level1, Level2, NewX, Game2).
   


pie_rule('y', State, Board, X, NewBoard) :-
    state \= pvp,
    findNonWhiteCell(Board, XReplace, YReplace),
    replaceCell(Board, XReplace, YReplace, X, NewBoard).


pie_rule('n', pvp, _Board, X) :-
    repeat,
    (
       write('Enter column: '),
       read_column(ColumnString),
       column(ColumnString, Column),
       write('Enter row: '),
       read_row(RowString),
       row(RowString, Row),
       (
          validate_move(_Board, Column, Row) -> 
          move(_Board, Row, Column, X, NewBoard),
          changeColor(X, NewX),
          run_game(pvp, NewBoard, NewX, 3); 
          write('Invalid move, please try again.'), nl,
          fail
        )
     ).

pie_rule('y', pvp, Board, X) :-
    findNonWhiteCell(Board, XReplace, YReplace),
    replaceCell(Board, XReplace, YReplace, X, NewBoard),
    changeColor(X, NewX),
    run_game(pvp, NewBoard, NewX, 3).

pie_rule('n', pvc, _Board, X, Y) :-
    repeat,
    (
       write('Enter column: '),
       read_column(ColumnString),
       column(ColumnString, Column),
       write('Enter row: '),
       read_row(RowString),
       row(RowString, Row),
       (
          validate_move(_Board, Column, Row) -> 
          move(_Board, Row, Column, X, NewBoard),
          changeColor(X, NewX),
          run_game(pvc, NewBoard, Y, NewX, 3); 
          write('Invalid move, please try again.'), nl,
          fail
        )
     ).


run_game(pvc, _Board, Level, blue, Y) :-
    display_game(_Board),
    botMove(pvc, _Board, blue, NewBoard, Level, 1),
    game_over(pvc, NewBoard, Level, blue, Y).

run_game(pvc, _Board, Level, red, Y) :-
    Y \= 2,
    display_game(_Board),
    repeat,
    (
       write('Enter column: '),
       read_column(ColumnString),
       column(ColumnString, Column),
       write('Enter row: '),
       read_row(RowString),
       row(RowString, Row),
       (
          validate_move(_Board, Column, Row) -> 
          move(_Board, Row, Column, X, NewBoard),
          write('\n'),
          game_over(pvc, NewBoard, Level, red, Y); 
          write('Invalid move, please try again.'), nl,
          fail
        )
     ).

run_game(pvc, _Board, Level, red, 2) :-
    display_game(_Board),
    write('Pie Rule (y/n): '),
    read_pie_rule(Rule),
    pie_rule(Rule, pvc, _Board, red, NewBoard),
    run_game(pvc, NewBoard, Level, blue, 3).



run_game(cvc, _Board, Level1, Level2, blue, Y) :-
    display_game(_Board),
    botMove(cvc, _Board, blue, NewBoard,Level1, Y),
    game_over(cvc, NewBoard, Level1, Level2, blue, Y).

run_game(cvc, _Board, Level1, Level2, red, Y) :-
    display_game(_Board),
    botMove(cvc, _Board, red, NewBoard,Level2, Y),
    game_over(cvc, NewBoard, Level1, Level2, red, Y).
    
    
