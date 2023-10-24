:- use_module(library(lists)).

replace(Idx, L1, Val, L2) :-
    length(L1, Length),
    Length > Idx,
    replace(Idx, L1, Val, L2, []).

replace(0, [_ | T], Val, L2, Acc) :-
    append(Acc, [Val], Acc1),
    append(Acc1, T, L2), !.

replace(Idx, [H | T], Val, L2, Acc) :-
    Idx > 0,
    append(Acc, [H], Acc1),
    Idx1 is Idx - 1,
    replace(Idx1, T, Val, L2, Acc1).


board_size(9).
board_size(7).

board_color(blue, 'B').
board_color(white, ' ').
board_color(red, 'R').

initialize_board(Board) :-
    board_size(Size),
    initialize_board(Size, Size, Board).

initialize_board(0, _, []).

initialize_board(Rows, Cols, [Row | Rest]) :-
    Rows > 0,
    initialize_row(Cols, Row),
    NextRows is Rows - 1,
    initialize_board(NextRows, Cols, Rest).

initialize_row(0, []).

initialize_row(Cols, [white | Rest]) :-
    Cols > 0,
    NextCols is Cols - 1,
    initialize_row(NextCols, Rest).

get_cell(Board, Row, Col, Cell) :-
    nth0(Row, Board, BoardRow),
    nth0(Col, BoardRow, Cell).


replaceCell(Board, X, Y, NewCell, NewBoard) :-
    nth0(Y, Board, Line),
    replace(X, Line, NewCell, NewLine),
    replace(Y, Board, NewLine, NewBoard).

    

print_board([]).

print_board([Row | Rest]) :-
    write('|'),
    print_row(Row),
    write('|'),
    nl,
    print_board(Rest).

print_row([]).

print_row([Cell | Rest]) :-
    board_color(Cell, X),
    write(X),
    print_row(Rest).

                 
