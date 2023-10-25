:-consult('io.pl').

%Prints the game title
print_title :-
    write('\t  __    __     ______     __    __     _______     ___    __     ___________     __    __     __    __ \n'),
    write('\t |   \\/   |   |  __  |   |   \\/   |   |   ____|   |   \\  |  |   |           |   |  |  |  |   |   \\/   |\n'),
    write('\t |        |   | |  | |   |        |   |  |__      |    \\ |  |   |___     ___|   |  |  |  |   |        |\n'),
    write('\t |  |\\/|  |   | |  | |   |  |\\/|  |   |   __|     |  |\\ \\|  |       |   |       |  |  |  |   |  |\\/|  |\n'),
    write('\t |  |  |  |   | |__| |   |  |  |  |   |  |____    |  | \\    |       |   |       |  |__|  |   |  |  |  |\n'),
    write('\t |__|  |__|   |______|   |__|  |__|   |_______|   |__|  \\___|       |___|       |________|   |__|  |__|\n'),
    write('\n').


valid_menu_options(['0', '1', '2']).
valid_submenu_options(['0', '1', '2', '3']).


%Prints the menu options
print_menu :-
    print_option('1', 'Play'),
    print_option('2', 'Rules'),
    print_option('0', 'Exit'),
    write('\n'),
    write('Select an option\n').


%Prints the submenu options
print_submenu :-
    print_option('1', 'Human VS Human'),
    print_option('2', 'Human VS Computer'),
    print_option('3', 'Computer VS Computer'),
    print_option('0', 'Get back'),
    write('\n'),
    write('Select an option\n').


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
   

handle_menu_option('2') :-
    write('\n'),
    write('Rules: \n'),
    write('Players take turns dropping one of their counters onto an empty cell of the game board.\n'), 
    write('The momentum of the dropped counter is transferred in up to eight directions through adjacent contiguous lines of counters.\n'),
    write('Counters at the end of these lines are pushed away one cell from the dropped counter.\n'),
    write('Some fall off the board and are returned to the owning players.\n'),
    write('The first player to have all of his or her counters on the board, at the end of his or her turn, wins the game.\n'),
    write('\n'),
    write('Menu: \n'),
    print_menu,
    read_option(SelectedOption),
    handle_menu_option(SelectedOption).


handle_menu_option('0') :-
    write('\n'),
    write('Goodbye!\n').



% Define a predicate to run the menu.
run_menu :-
    print_title,
    print_menu,
    read_option(SelectedOption),
    handle_menu_option(SelectedOption).  