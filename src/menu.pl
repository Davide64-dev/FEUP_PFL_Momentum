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
    write('Select an option\n').


%Prints the submenu options
print_submenu :-
    print_option('1', 'Human VS Human'),
    print_option('2', 'Human VS Computer'),
    print_option('3', 'Computer VS Computer'),
    print_option('0', 'Get back'),
    write('Select an option\n').


%Prints the board size options
print_board_menu :-
    print_option('1', '7 X 7'),
    print_option('2', '7 X 9'),
    print_option('3', '9 X 9'),
    write('Select a board size\n').


%Define how to act after each choice from the user in the submenu
handle_submenu_option('1') :-
    print_board_menu,
    read_option(SelectedOption),
    handle_submenu_option(SelectedOption).


%Define how to act after each choice from the user in the menu
handle_menu_option('1') :-
    print_submenu,
    read_option(SelectedOption),
    handle_submenu_option(SelectedOption). 
   

handle_menu_option('2') :- write('You chose rules.\n').
handle_menu_option('0') :- write('Goodbye!\n').



% Define a predicate to run the menu.
run_menu :-
    print_title,
    print_menu,
    read_option(SelectedOption),
    handle_menu_option(SelectedOption).  