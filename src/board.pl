
board_size(9).


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
