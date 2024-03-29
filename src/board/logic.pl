% Define the number of pieces based on the board dimensions
% nrPieces(+Width, +Height, -NumberOfPieces)
nrPieces(7, 7, 8).
nrPieces(7, 9, 10).
nrPieces(9, 7, 10).
nrPieces(9, 9, 12).


% Change the color between the players
% changeColor(+Color, -FinalColor)
changeColor(blue, red).
changeColor(red, blue).


% Define the first element of a list 
% first_element(+List, -Elem)
first_element([X|_], X).


% Place a piece on the board
% move(+Board, +XCoordinate, +YCoordinate, +NewValue, -NewBoard)
move(Board, X, Y, NewCell, NewBoard) :-
    length(Board, YMax),
    nth1(1, Board, Temp),
    length(Temp, XMax),
    
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


% Check if a move is valid
% validate_move(+Board, +XCoordinate, +YCoordinate)
validate_move(Board, X, Y) :-
        length(Board, YMax),
        first_element(Board, Temp),
        length(Temp, XMax),
        X > 0,
        X < XMax,
        Y > 0,
        Y < YMax,
        get_cell(Board, Y, X, Cell),
        Cell == white.


% Find a cell that is not white (empty)
% findNonWhiteCell(+Board, -XCoordinate, -YCoordinate)
findNonWhiteCell(Board, X, Y) :-
    nth0(X, Board, Row),
    nth0(Y, Row, Cell),   
    Cell \= white.  


% Check if a cell is empty (white)
% emptyCell(+Board, +XCoordinate, +YCoordinate)
emptyCell(Board, X, Y) :-
    nth0(X, Board, Row),
    nth0(Y, Row, Cell),
    Cell == white.


% Find all empty cells on the board
% findEmptyCells(+Board, -EmptyCells)
findEmptyCells(Board, EmptyCells) :-
    findall([X, Y], emptyCell(Board, X, Y), EmptyCells).


% Count the number of occurences of an element in a list
% countElement(+List, +Element, -Number)
countElement([], _, 0).

countElement([X|T], X, N) :-
    countElement(T, X, N1),
    N is N1 + 1.

countElement([_|T], X, N) :-
    countElement(T, X, N).


% Helper predicate to count the occurrences of a color in each row
% countRows(+List, +Color, -Count)
countRows([], _, 0).

countRows([Row|Rows], Color, Count) :-
    countElement(Row, Color, Count1),
    countRows(Rows, Color, Count2),
    Count is Count1 + Count2.


% Predicate to count the cells of a certain color
% countCells(+Board, +Color, -Count)
countCells(Board, Color, Count) :-
    countRows(Board, Color, Count).


% Define the behavior of pushing game pieces on the board based on movement directions
% pushPiece(+Board, +XCoordinate, +YCoordinate, +IncX, +IncY, -NewBoard)
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

        
% Clear the pieces from the game borders
% clearBoarders(+Board, +Width, +Height, -NewBoard)
clearBoarders(Board, Width, Height, NewBoard) :-
    clearColumn(Board, 0, Height, 0, TempBoard1), % Clear the first column
    clearRow(TempBoard1, 0, Width, 0, TempBoard2), % Clear the first row
    Height1 is Height - 1,
    Width1 is Width - 1,
    clearRow(TempBoard2, Height1, Width, 0, TempBoard3), % Clear the last row
    clearColumn(TempBoard3, Width1, Height, 0, NewBoard). % Clear the last column


% Clear the pieaces from a row
% clearRow(+Board, +Row, N_Colums, +Start, -Board)
clearRow(Board, _, N_columns, N_columns, Board).

clearRow(Board, Row, N_columns, Start, NewBoard) :-
    Start < N_columns,
    replaceCell(Board, Row, Start, white, UpdatedBoard),
    Start1 is Start + 1,
    clearRow(UpdatedBoard, Row, N_columns, Start1, NewBoard).


% Clear the pieaces from a column
% clearColumn(+Board, +Column, +Height, +Start, -NewBoard)
clearColumn(Board, _, Height, Height, Board).

clearColumn(Board, Column, Height, Start, NewBoard) :-
    Start < Height,
    replaceCell(Board, Start, Column, white, UpdatedBoard),
    Start1 is Start + 1,
    clearColumn(UpdatedBoard, Column, Height, Start1, NewBoard).

