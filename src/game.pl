
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
          winner(pvp, NewBoard, X, Y); 
          write('Invalid move, please try again.'), nl,
          fail
        )
     ).

run_game(pvp, _Board, X, 2) :-
    print_board(_Board),
    write('Pie Rule (y/n): '),
    read_pie_rule(Rule),
    pie_rule(Rule, pvp, _Board, X).

winner(pvp, NewBoard, X, Y) :-
    countCells(NewBoard, X, Count),
    length(NewBoard, XMax),
    nth1(1, NewBoard, Temp),
    length(Temp, YMax),
    nrPieces(XMax, YMax, Expected),
    Count = Expected,
    write('The '),
    write(X),
    write(' has won\n').

winner(pvp, NewBoard, X, Y) :-
    countCells(NewBoard, X, Count),
    length(NewBoard, XMax),
    nth1(1, NewBoard, Temp),
    length(Temp, YMax),
    nrPieces(XMax, YMax, Expected),
    Count \= Expected,
    Game2 is Y + 1,
    changeColor(X, NewX),
    run_game(pvp, NewBoard, NewX, Game2).

winner(pvc, Board, Level, X, Y) :-
    countCells(Board, X, Count),
    length(Board, XMax),
    nth1(1, Board, Temp),
    length(Temp, YMax),
    nrPieces(XMax, YMax, Expected),
    Count \= Expected,
    Game2 is Y + 1,
    changeColor(X, NewX),
    run_game(pvc, Board, Level, NewX, Game2).

winner(pvc, Board, Level, X, Y) :-
    countCells(Board, X, Count),
    length(Board, XMax),
    nth1(1, Board, Temp),
    length(Temp, YMax),
    nrPieces(XMax, YMax, Expected),
    Count = Expected,
    write('The '),
    write(X),
    write(' has won\n').
   


pie_rule('y', State, Board, X) :-
    findNonWhiteCell(Board, XReplace, YReplace),
    replaceCell(Board, XReplace, YReplace, X, NewBoard),
    changeColor(X, NewX),
    run_game(State, NewBoard, NewX, 3).

pie_rule('y', State, Board, X, Y) :-
    findNonWhiteCell(Board, XReplace, YReplace),
    replaceCell(Board, XReplace, YReplace, X, NewBoard),
    changeColor(X, NewX),
    run_game(State, NewBoard, Y, NewX, 3).

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
          putPiece(_Board, Row, Column, X, NewBoard),
          changeColor(X, NewX),
          run_game(pvc, NewBoard, Y, NewX, 3); 
          write('Invalid move, please try again.'), nl,
          fail
        )
     ).


run_game(pvc, _Board, Level, blue, Y) :-
    Y \= 2,
    print_board(_Board),
    botMove(_Board, blue, NewBoard, Level, 1),
    winner(pvc, NewBoard, Level, blue, Y).

run_game(pvc, _Board, Level, red, Y) :-
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
          winner(pvc, NewBoard, Level, red, Y); 
          write('Invalid move, please try again.'), nl,
          fail
        )
     ).

run_game(pvc, _Board, Level, red, 2) :-
    print_board(_Board),
    write('Pie Rule (y/n): '),
    read_pie_rule(Rule),
    pie_rule(Rule, pvc, _Board, red, Level).


run_game(pvc, _Board, Level, blue, 2) :-
    print_board(_Board),
    botMove(_Board, blue, NewBoard, Level, 2),
    run_game(pvc, NewBoard, Level, red, 3).



run_game(cvc, _Board, Level1, Level2, blue, Y) :-
    print_board(_Board),
    botMove(_Board, blue, NewBoard,Level1, Y),
    Y1 is Y + 1,
    write('Cheguei Aqui!'),
    run_game(cvc, NewBoard, Level1, Level2, red, Y1).

run_game(cvc, _Board, Level1, Level2, red, Y) :-
    print_board(_Board),
    botMove(_Board, blue, NewBoard,Level1, Y),
    Y1 is Y + 1,
    run_game(cvc, NewBoard, Level1, Level2, blue, Y1).
    
    
