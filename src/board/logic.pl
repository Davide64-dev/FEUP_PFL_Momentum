<<<<<<< HEAD
:- consult('board.pl').
=======
:-consult('board.pl').
>>>>>>> e20c433c0ccbc101854b8c449fb28bc556da1584

nrPieces(7, 7, 8).
nrPieces(7, 9, 10).
nrPieces(9, 9, 12).

first_element([X|_], X).

putPiece(Board, X, Y, NewCell, NewBoard) :-
        length(Board, XMax),
        first_element(Board, Temp),
        length(Temp, YMax),
        X > 0,
        X < XMax - 1,
        Y > 0,
        Y < YMax - 1,

        get_cell(Board, X, Y, Cell),
        X1 is X + 1,
        Y1 is Y + 1,
        X2 is X - 1,
        Y2 is Y - 1,
        Cell == white,
        replaceCell(Board, X, Y, NewCell, Board1),
        pushPiece(Board1, X1, Y, 1, 0, Board2),
        pushPiece(Board2, X1, Y1, 1, 1, Board3),
        pushPiece(Board3, X, Y1, 0, 1, Board4),
        pushPiece(Board4, X2, Y1, -1, 1, Board5),
        pushPiece(Board5, X2, Y, -1, 0, Board6),
        pushPiece(Board6, X2, Y2, -1, -1, Board7),
        pushPiece(Board7, X, Y2, 0, -1, Board8),
<<<<<<< HEAD
        pushPiece(Board8, X1, Y2, 1, -1, NewBoard).
=======
        pushPiece(Board8, X1, Y2, 1, -1, Board9),
        clearBoarders(Board9, XMax, YMax, NewBoard).
>>>>>>> e20c433c0ccbc101854b8c449fb28bc556da1584
        

pushPiece(Board, X, Y, IncX, IncY, NewBoard) :-
        X1 is X + IncX,
        Y1 is Y + IncY,
        get_cell(Board, X1, Y1, Cell),
        Cell == white,
        get_cell(Board, X, Y, Cell1),
        Cell1 \= white,
        replaceCell(Board, X1, Y1, Cell1, Board1),
        replaceCell(Board1, X, Y, white, NewBoard).

pushPiece(Board, X, Y, IncX, IncY, Board) :-
        get_cell(Board, X, Y, Cell),
        Cell == white.

pushPiece(Board, X, Y, IncX, IncY, NewBoard) :-
        X1 is X + IncX,
        Y1 is Y + IncY,
        get_cell(Board, X1, Y1, Cell),
        get_cell(Board, X, Y, Cell1),
        Cell \= white,
        Cell1 \= white,
        pushPiece(Board, X1, Y1, IncX, IncY, NewBoard).

<<<<<<< HEAD
init :- initialize_board(9, 9, _X), putPiece(_X, 3, 3, blue, _Y), putPiece(_Y, 2, 2, red,_Z), print_board(_Z), putPiece(_Z, 8, 8, red, _W), print_board(_W).
        
=======
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
        putPiece(_W, 2, 2, blue, _A), print_board(_A).
>>>>>>> e20c433c0ccbc101854b8c449fb28bc556da1584
