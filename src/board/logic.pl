nrPieces(7, 7, 8).
nrPieces(7, 9, 10).
nrPieces(9, 9, 12).

changeColor(blue, red).
changeColor(red, blue).

first_element([X|_], X).

putPiece(Board, X, Y, NewCell, NewBoard) :-
    length(Board, XMax),
    nth1(1, Board, Temp),
    length(Temp, YMax),
    
    X1 is X + 1,
    Y1 is Y + 1,
    X2 is X - 1,
    Y2 is Y - 1,
    
    replaceCell(Board, X, Y, NewCell, Board1),
    pushPiece(Board1, X1, Y, 1, 0, Board2),
    pushPiece(Board2, X1, Y1, 1, 1, Board3),
    pushPiece(Board3, X, Y1, 0, 1, Board4),
    pushPiece(Board4, X2, Y1, -1, 1, Board5),
    pushPiece(Board5, X2, Y, -1, 0, Board6),
    pushPiece(Board6, X2, Y2, -1, -1, Board7),
    pushPiece(Board7, X, Y2, 0, -1, Board8),
    pushPiece(Board8, X1, Y2, 1, -1, Board9),
    clearBoarders(Board9, XMax, YMax, NewBoard).

validate_move(Board, X, Y) :-
        length(Board, XMax),
        first_element(Board, Temp),
        length(Temp, YMax),
        X > 0,
        X < XMax,
        Y > 0,
        Y < YMax,
        get_cell(Board, X, Y, Cell),
        Cell == white.

findNonWhiteCell(Board, X, Y) :-
    nth0(X, Board, Row),
    nth0(Y, Row, Cell),   
    Cell \= white.  


countElement([], _, 0).
countElement([X|T], X, N) :-
    countElement(T, X, N1),
    N is N1 + 1.
countElement([_|T], X, N) :-
    countElement(T, X, N).

% Helper predicate to count the occurrences of a color in each row
countRows([], _, 0).
countRows([Row|Rows], Color, Count) :-
    countElement(Row, Color, Count1),
    countRows(Rows, Color, Count2),
    Count is Count1 + Count2.

% Predicate to count the cells of a certain color
countCells(Board, Color, Count) :-
    countRows(Board, Color, Count).






pushPiece(Board, X, Y, IncX, IncY, Board) :-
    get_cell(Board, X, Y, Cell),
    Cell == white.

pushPiece(Board, X, Y, IncX, IncY, NewBoard) :-
    X1 is X + IncX,
    Y1 is Y + IncY,
    get_cell(Board, X1, Y1, NextCell),
    get_cell(Board, X, Y, CurrentCell),
    NextCell == white,
    CurrentCell \= white,
    replaceCell(Board, X1, Y1, CurrentCell, Board1),
    replaceCell(Board1, X, Y, white, NewBoard).

pushPiece(Board, X, Y, IncX, IncY, NewBoard) :-
    X1 is X + IncX,
    Y1 is Y + IncY,
    get_cell(Board, X1, Y1, Cell),
    get_cell(Board, X, Y, Cell1),
    Cell \= white,
    Cell1 \= white,
    pushPiece(Board, X1, Y1, IncX, IncY, NewBoard).

        
clearBoarders(Board, Width, Height, NewBoard) :-
    clearColumn(Board, 0, Height, 0, TempBoard1), % Clear the first column
    clearRow(TempBoard1, 0, Width, 0, TempBoard2), % Clear the first row
    Height1 is Height - 1,
    Width1 is Width - 1,
    clearRow(TempBoard2, Height1, Width, 0, TempBoard3), % Clear the last row
    clearColumn(TempBoard3, Width1, Height, 0, NewBoard). % Clear the last column

clearRow(Board, _, N_columns, N_columns, Board).
clearRow(Board, Row, N_columns, Start, NewBoard) :-
    Start < N_columns,
    replaceCell(Board, Row, Start, white, UpdatedBoard),
    Start1 is Start + 1,
    clearRow(UpdatedBoard, Row, N_columns, Start1, NewBoard).

clearColumn(Board, _, Height, Height, Board).
clearColumn(Board, Column, Height, Start, NewBoard) :-
    Start < Height,
    replaceCell(Board, Start, Column, white, UpdatedBoard),
    Start1 is Start + 1,
    clearColumn(UpdatedBoard, Column, Height, Start1, NewBoard).

init :- initialize_board(9, 9, _X),
        putPiece(_X, 3, 3, blue, _Y),print_board(_Y), write('\n'),
        putPiece(_Y, 2, 2, red,_Z), print_board(_Z), write('\n'),
        putPiece(_Z, 3, 3, blue, _W), print_board(_W), write('\n'),
        putPiece(_W, 2, 2, blue, _A),print_board(_A).

init2 :- initialize_board(9, 9, X), putPiece(X, 3, 4, blue, Y), print_board(Y).
