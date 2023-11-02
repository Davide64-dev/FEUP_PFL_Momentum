run_game(pvp, _Board, X, Y) :-
    Y \= 2,
    print_board(_Board),
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
          putPiece(_Board, Row, Column, X, NewBoard),
          write('\n'),
          winner(NewBoard, X, Y); 
          write('Invalid move, please try again.'), nl,
          fail
        )
     ).

run_game(pvp, _Board, X, 2) :-
    print_board(_Board),
    write('Pie Rule (y/n): '),
    read_pie_rule(Rule),
    pie_rule(Rule, pvp, _Board, X).

winner(NewBoard, X, Y) :-
    countCells(NewBoard, X, Count),
    length(NewBoard, XMax),
    nth1(1, NewBoard, Temp),
    length(Temp, YMax),
    nrPieces(XMax, YMax, Expected),
    Count = Expected,
    write('The '),
    write(X),
    write(' has won\n').

winner(NewBoard, X, Y) :-
    countCells(NewBoard, X, Count),
    length(NewBoard, XMax),
    nth1(1, NewBoard, Temp),
    length(Temp, YMax),
    nrPieces(XMax, YMax, Expected),
    Count \= Expected,
    Game2 is Y + 1,
    changeColor(X, NewX),
    run_game(pvp, NewBoard, NewX, Game2).
   


pie_rule('y', State, Board, X) :-
    findNonWhiteCell(Board, XReplace, YReplace),
    replaceCell(Board, XReplace, YReplace, X, NewBoard),
    changeColor(X, NewX),
    run_game(State, NewBoard, NewX, 3).

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
          putPiece(_Board, Row, Column, X, NewBoard),
          changeColor(X, NewX),
          run_game(pvp, NewBoard, NewX, 3); 
          write('Invalid move, please try again.'), nl,
          fail
        )
     ).



run_game(pvc, _Board, Level, First) :-
    print_board(_Board),
    read_column(ColumnString),
    read_row(RowString),
    column(ColumnString, Column),
    row(RowString, Row),
    putPiece(_Board, Column, Row, _NewCell, _NewBoard),
    print_board(_NewBoard).

run_game(cvc, _Board, Level1, Level2) :-
    print_board(_Board),
    read_column(ColumnString),
    read_row(RowString),
    column(ColumnString, Column),
    row(RowString, Row),
    putPiece(_Board, Column, Row, _NewCell, _NewBoard),
    print_board(_NewBoard).
