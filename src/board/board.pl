% Associate the column letter to the according number
% column(+Letter, -Number) 
column('A', 0).
column('B', 1).
column('C', 2).
column('D', 3).
column('E', 4).
column('F', 5).
column('G', 6).
column('H', 7).
column('I', 8).


% Associate the string of the row number to the according number
% row(+Choice, -Number)   
row('0', 0).
row('1', 1).
row('2', 2).
row('3', 3).
row('4', 4).
row('5', 5).
row('6', 6).
row('7', 7).
row('8', 8).


% Define the valid board sizes
% board_size(+Size)
board_size(9).
board_size(7).


% Associate the color name to the correct letter
% board_color(+Color, -Symbol)
board_color(blue, 'B').
board_color(white, ' ').
board_color(red, 'R').


% Define the initial state of the board
% initial_state(-Board)
initial_state(Board) :-
    board_size(Size),
    initial_state(Size, Size, Board).


% Define the board's initial state
% initial_state(+Rows, +Cols, -List)
initial_state(0, _, []).

initial_state(Rows, Cols, [Row | Rest]) :-
    Rows > 0,
    initialize_row(Cols, Row),
    NextRows is Rows - 1,
    initial_state(NextRows, Cols, Rest).


% Define the initial state of a row of the board
% initialize_row(+Columns, -List)
initialize_row(0, []).

initialize_row(Cols, [white | Rest]) :-
    Cols > 0,
    NextCols is Cols - 1,
    initialize_row(NextCols, Rest).


% Get a specific cell from the board
% get_cell(+Board, +XCoordinate, +YCoordinate)
get_cell(Board, X, Y, Cell) :-
    nth0(X, Board, Row),
    nth0(Y, Row, Cell).


% Determine all the valid moves in the board
% valid_moves(+Matrix, -ValidPairs)
valid_moves(Matrix, ValidPairs) :-
    findall((X, Y), (
        nth0(X, Matrix, Row), 
        nth0(Y, Row, _),
        validate_move(Matrix, X, Y)
    ), ValidPairs).


% Replaces a cell for another
% replaceCell(+Board, +XCoordinate, +YCoordinate, +NewCell, -NewBoard)
replaceCell(Board, X, Y, NewCell, NewBoard) :-
    nth0(X, Board, Row),
    replace(Row, Y, NewCell, NewRow),
    replace(Board, X, NewRow, NewBoard).


% Replace an element in a list at a given index
% replace(+List, +Index, +NewElement, -ResultList)
replace([_|T], 0, X, [X|T]).

replace([H|T], I, X, [H|R]) :- 
    I > 0, 
    I1 is I - 1, 
    replace(T, I1, X, R).
    

% Print column labels based on the board size.
% print_column_labels(+BoardSize)
print_column_labels(0) :- write('|').

print_column_labels(9) :-
    write('  ABCDEFGHI \n'),
    write(' -----------\n').

print_column_labels(7) :-
    write('  ABCDEFG \n'),
    write(' ---------\n').


% Display the game board
% display_game(+Board)
display_game([Row | Rest]) :-
    length(Row, Length),
    print_column_labels(Length),
    print_board_aux([Row | Rest], 0).


% Auxiliar to print the board
% print_board_aux(+Board, +Count)
print_board_aux([], _).

print_board_aux([Row | Rest], Count) :-
    write(Count),
    Count1 is Count + 1,
    write('|'),
    print_row(Row),
    write('|'),
    nl,
    print_board_aux(Rest, Count1).


% Print a row of the board
% print_row(+Row)
print_row([]).

print_row([Cell | Rest]) :-
    board_color(Cell, X),
    write(X),
    print_row(Rest).       
