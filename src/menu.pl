:-consult('io.pl').
:-consult('board/board.pl').

%Prints the game title
print_title :-
    write('\t  __    __     ______     __    __     _______     ___    __     ___________     __    __     __    __ \n'),
    write('\t |   \\/   |   |  __  |   |   \\/   |   |   ____|   |   \\  |  |   |           |   |  |  |  |   |   \\/   |\n'),
    write('\t |        |   | |  | |   |        |   |  |__      |    \\ |  |   |___     ___|   |  |  |  |   |        |\n'),
    write('\t |  |\\/|  |   | |  | |   |  |\\/|  |   |   __|     |  |\\ \\|  |       |   |       |  |  |  |   |  |\\/|  |\n'),
    write('\t |  |  |  |   | |__| |   |  |  |  |   |  |____    |  | \\    |       |   |       |  |__|  |   |  |  |  |\n'),
    write('\t |__|  |__|   |______|   |__|  |__|   |_______|   |__|  \\___|       |___|       |________|   |__|  |__|\n'),
    write('\n').


valid_menu_options(['0', '1', '2', '3']).
valid_submenu_options(['0', '1', '2', '3']).

handle(start, '1', play).
handle(start, '2', rules).
handle(start, '0', exit).
handle(rules, '0', start).
handle(play, '1', pvp).
handle(play, '2', pvc).
handle(play, '3', cvc).

numToBoard('1', '7 X 7').
numToBoard('2', '7 X 9').
numToBoard('3', '9 X 9').

board_dimensions('7 X 7', 7, 7).
board_dimensions('7 X 9', 7, 9).
board_dimensions('9 X 9', 9, 9).



%Prints the menu options
print_menu(start, Res) :-
    print_option('1', 'Play'),
    print_option('2', 'Rules'),
    print_option('0', 'Exit'),
    write('\n'),
    write('Select an option\n'),
    read_option(Temp),
    handle(start, Temp, Res).

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

print_menu(play, Res) :-
    write('\n'),
    print_option('1', 'Human VS Human'),
    print_option('2', 'Human VS Computer'),
    print_option('3', 'Computer VS Computer'),
    print_option('0', 'Get back'),
    write('\n'),
    write('Select a Game Type\n'),
    read_option(Temp),
    handle(play, Temp, Res).


%Prints the board size options
print_board_menu :-
    print_option('1', '7 X 7'),
    print_option('2', '7 X 9'),
    print_option('3', '9 X 9'),
    print_option('0', 'Get back'),
    write('\n'),
    write('Select a board size\n').


%Prints the levels menu
print_levels_menu :-
    print_option('1', 'Level 1'),
    print_option('2', 'Level 2'),
    print_option('0', 'Get back'),
    write('\n'),
    write('Select a level\n').


%Define how to handle each choice from the user in the board menu
handle_board_menu_option('1') :-
    write('P VS P').

handle_board_menu_option('2') :-
    write('\n'),
    print_levels_menu,
    read_option(SelectedOption),
    handle_level_menu_option(SelectedOption).

handle_board_menu_option('3') :-
    write('\n'),
    print_levels_menu,
    read_option(SelectedOption),
    handle_level_menu_option(SelectedOption).


handle_board_menu_option('0') :-
    write('\n'),
    print_levels_menu,
    read_option(SelectedOption),
    handle_submenu_option(SelectedOption).


%Define how to handle each user choice in the levels' menu
handle_level_menu_option('1') :-
    write('\n'),
    write('Level1\n').

handle_level_menu_option('2') :-
    write('\n'),
    write('Level2\n').

handle_level_menu_option('0') :-
    write('\n'),
    print_board_menu,
    read_option(SelectedOption),
    handle_board_menu_option(SelectedOption).
    


%Define how to handle each choice from the user in the submenu
handle_submenu_option('1') :-
    write('\n'),
    print_board_menu,
    read_option(SelectedOption),
    handle_board_menu_option(SelectedOption).


handle_submenu_option('2') :-
    write('\n'),
    print_board_menu,
    read_option(SelectedOption),
    handle_board_menu_option(SelectedOption).


handle_submenu_option('3') :-
    write('\n'),
    print_board_menu,
    read_option(SelectedOption),
    handle_board_menu_option(SelectedOption).


handle_submenu_option('0') :-
    write('\n'),
    print_menu,
    read_option(SelectedOption),
    handle_menu_option(SelectedOption).



%Define how to handle each choice from the user in the menu
handle_menu_option('1') :-
    write('\n'),
    print_submenu,
    read_option(SelectedOption),
    handle_submenu_option(SelectedOption). 


handle_menu_option('0') :-
    write('\n'),
    write('Goodbye!\n').



% Define a predicate to run the menu.
run_menu :-
    print_title,
    menu(start).


menu(State) :-
        State \= exit,
        State \= pvp,
        State \= pvc,
        State \= cvc,
        print_menu(State, Res),
        menu(Res).

menu(pvp) :-
    print_board_menu,
    read_option(Temp),
    numToBoard(Temp, Temp1),
    board_dimensions(Temp1, Width, Height),
    initialize_board(Width, Height, _Board),
    print_board(_Board).

menu(pvc) :-
    print_board_menu,
    read_option(Temp),
    numToBoard(Temp, Temp1),
    board_dimensions(Temp1, Width, Height),
    initialize_board(Width, Height, _Board),
    print_board(_Board).

menu(cvc) :-
    print_board_menu,
    read_option(Temp),
    numToBoard(Temp, Temp1),
    board_dimensions(Temp1, Width, Height),
    initialize_board(Width, Height, _Board),
    print_board(_Board).
        

menu(exit).

