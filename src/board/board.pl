:- use_module(library(lists)).

column('A', 0).
column('B', 1).
column('C', 2).
column('D', 3).
column('E', 4).
column('F', 5).
column('G', 6).
column('H', 7).
column('I', 8).

row('0', 0).
row('1', 1).
row('2', 2).
row('3', 3).
row('4', 4).
row('5', 5).
row('6', 6).
row('7', 7).
row('8', 8).


board_size(9).
board_size(7).

board_color(blue, 'B').
board_color(white, ' ').
board_color(red, 'R').

initial_state(Board) :-
    board_size(Size),
    initial_state(Size, Size, Board).

initial_state(0, _, []).

initial_state(Rows, Cols, [Row | Rest]) :-
    Rows > 0,
    initialize_row(Cols, Row),
    NextRows is Rows - 1,
    initial_state(NextRows, Cols, Rest).

initialize_row(0, []).

initialize_row(Cols, [white | Rest]) :-
    Cols > 0,
    NextCols is Cols - 1,
    initialize_row(NextCols, Rest).

get_cell(Board, X, Y, Cell) :-
    nth0(X, Board, Row),
    nth0(Y, Row, Cell).


valid_moves(Matrix, ValidPairs) :-
    findall((X, Y), (
        nth0(X, Matrix, Row), 
        nth0(Y, Row, _),
        validate_move(Matrix, X, Y)
    ), ValidPairs).


replaceCell(Board, X, Y, NewCell, NewBoard) :-
    nth0(X, Board, Row),
    replace(Row, Y, NewCell, NewRow),
    replace(Board, X, NewRow, NewBoard).

replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]) :- 
    I > 0, 
    I1 is I - 1, 
    replace(T, I1, X, R).
    

print_column_labels(0) :- write('|').

print_column_labels(9) :-
    write('  ABCDEFGHI \n'),
    write(' -----------\n').


print_column_labels(7) :-
    write('  ABCDEFG \n'),
    write(' ---------\n').


display_game([Row | Rest]) :-
    length(Row, Length),
    print_column_labels(Length),
    print_board_aux([Row | Rest], 0).



print_board_aux([], _).

print_board_aux([Row | Rest], Count) :-
    write(Count),
    Count1 is Count + 1,
    write('|'),
    print_row(Row),
    write('|'),
    nl,
    print_board_aux(Rest, Count1).

print_row([]).

print_row([Cell | Rest]) :-
    board_color(Cell, X),
    write(X),
    print_row(Rest).


                 
