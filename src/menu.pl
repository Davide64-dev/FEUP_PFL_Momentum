% Maps the user's choice for who plays first to the corresponding player color.
% decodeFirst(+Choice, -Color)
decodeFirst('1', red).
decodeFirst('2', blue).


% Display the game title
% print_title/0
print_title :-
    write('\t  __    __     ______     __    __     _______     ___    __     ___________     __    __     __    __ \n'),
    write('\t |   \\/   |   |  __  |   |   \\/   |   |   ____|   |   \\  |  |   |           |   |  |  |  |   |   \\/   |\n'),
    write('\t |        |   | |  | |   |        |   |  |__      |    \\ |  |   |___     ___|   |  |  |  |   |        |\n'),
    write('\t |  |\\/|  |   | |  | |   |  |\\/|  |   |   __|     |  |\\ \\|  |       |   |       |  |  |  |   |  |\\/|  |\n'),
    write('\t |  |  |  |   | |__| |   |  |  |  |   |  |____    |  | \\    |       |   |       |  |__|  |   |  |  |  |\n'),
    write('\t |__|  |__|   |______|   |__|  |__|   |_______|   |__|  \\___|       |___|       |________|   |__|  |__|\n'),
    write('\n').


% Indicate the valid menu options
% valid_menu_options(+Options)
valid_menu_options(['0', '1', '2', '3']).


% Indicate the valid submenu options
% valid_submenu_options(+Options)
valid_submenu_options(['0', '1', '2', '3']).


% Indicates the valid options for the columns 
% valid_column_options(+Options)
valid_column_options(['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I']).


% Indicates the valid options for the rows
% valid_row_options(+Options)
valid_row_options(['0', '1', '2', '3', '4', '5', '6', '7', '8']).


% Indicate the handles of the menus
% handle(+State, +Choice, -FinalState)
handle(start, '1', play).
handle(start, '2', rules).
handle(start, '0', exit).
handle(rules, '0', start).
handle(play, '1', pvp).
handle(play, '2', pvc).
handle(play, '3', cvc).


% Indicate the transformation beteween the user choice and the dimension of the board
% numToBoard(+Num, -Size)
numToBoard('1', '7 X 7').
numToBoard('2', '7 X 9').
numToBoard('3', '9 X 9').


% Tranform the string with the board dimensions in two values for the width and height
% board_dimensions(+Size, -Width, -Height)
board_dimensions('7 X 7', 7, 7).
board_dimensions('7 X 9', 7, 9).
board_dimensions('9 X 9', 9, 9).



% Display the main menu options and handles the user's choice
% print_menu(+State, -Result)
print_menu(start, Res) :-
    print_option('1', 'Play'),
    print_option('2', 'Rules'),
    print_option('0', 'Exit'),
    write('\n'),
    write('Select an option\n'),
    read_option(Temp),
    handle(start, Temp, Res).


% Display the rules of the game
% print_menu(+State, -Result)
print_menu(rules, Res) :-
    write('\n'),
    write('Rules: \n\n'),
    write('- Players take turns dropping one of their counters onto an empty cell of the game board.\n\n'), 
    write('- The momentum of the dropped counter is transferred in up to eight directions through adjacent contiguous lines of counters.\n\n'),
    write('- Counters at the end of these lines are pushed away one cell from the dropped counter.\n\n'),
    write('- Some fall off the board and are returned to the owning players.\n\n'),
    write('- The first player to have all of his or her counters on the board, at the end of his or her turn, wins the game.\n\n'),
    write('\n'),
    write('Menu: \n'),
    print_option('0', 'Exit'),
    read_option(Temp),
    handle(rules, Temp, Res).


% Display the menu where the user chooses the game mode and handles the choice
% print_menu(+State, -Result)
print_menu(play, Res) :-
    write('\n'),
    print_option('1', 'Human VS Human'),
    print_option('2', 'Human VS Computer'),
    print_option('3', 'Computer VS Computer'),
    write('\n'),
    write('Select a Game Type\n'),
    read_option(Temp),
    handle(play, Temp, Res).


% Display the board size options
% print_board_menu(+State, -Result)
print_board_menu :-
    print_option('1', '7 X 7'),
    print_option('2', '7 X 9'),
    print_option('3', '9 X 9'),
    write('\n'),
    write('Select a board size\n').


% Display the levels options
% print_levels_menu(+State, -Result)
print_levels_menu :-
    print_option('1', 'Level 1'),
    print_option('2', 'Level 2'),
    write('\n'),
    write('Select a level\n').


% Display the menu where we choose who plays first
% print_plays_first/0
print_plays_first :-
    print_option('1', 'Player'),
    print_option('2', 'Computer'),
    write('\n'),
    write('Select who plays First\n').


% Define a predicate to run the menu
% run_menu/0
run_menu :-
    print_title,
    menu(start).


% Define menu predicate
% menu(+State)
menu(State) :-
        State \= exit,
        State \= pvp,
        State \= pvc,
        State \= cvc,
        print_menu(State, Res),
        menu(Res).


% Handle the menu option for Person vs. Person (pvp)
% menu(+Mode)
menu(pvp) :-
    print_board_menu,
    read_option(Temp),
    numToBoard(Temp, Temp1),
    board_dimensions(Temp1, Width, Height),
    initial_state(Width, Height, _Board),
    run_game(pvp, _Board, blue, 1).


% Handle the menu option for Person vs. Computer (pvc)
% menu(+Mode)
menu(pvc) :-
    print_board_menu,
    read_option(Temp),
    numToBoard(Temp, Temp1),
    board_dimensions(Temp1, Width, Height),
    initial_state(Width, Height, _Board),
    print_levels_menu,
    read_option(Level),
    print_plays_first,
    read_option(First),
    decodeFirst(First, FirstReal),
    run_game(pvc, _Board, Level, FirstReal, 1).


% Handle the menu option for Computer vs. Computer (cvc)
% menu(+Mode)
menu(cvc) :-
    print_board_menu,
    read_option(Temp),
    numToBoard(Temp, Temp1),
    board_dimensions(Temp1, Width, Height),
    initial_state(Width, Height, _Board),
    print_levels_menu,
    read_option(Level1),
    print_levels_menu,
    read_option(Level2),
    run_game(cvc, _Board, Level1, Level2, blue, 1).


% Handle the menu option when the users choses to leave the game
% menu(+State)
menu(exit) :-
    write('\n'),
    write('Goodbye!\n').
