% Define the valid boolean options
valid_boolean_answers(['y', 'n']).


% Print one menu option 
% print_option(+Key, +Text)
print_option(Key, Text) :-
    format('~w. ~w\n', [Key, Text]).


% Read the option chosen by the user in the menus
% read_option(-Option)
read_option(Option) :-
    valid_menu_options(ValidOptions),
    repeat,
    read_input([Input|_]),
    (member(Input, ValidOptions) -> Option = Input, !;
     write('Invalid Option. Please try again!\n'), fail).


% Read the column chosen by the user
% read_column(-Option)
read_column(Option) :-
    valid_column_options(ValidOptions),
    repeat,
    read_input([Input|_]),
    (member(Input, ValidOptions) -> Option = Input, !;
     write('Invalid Option. Please try again!\n'), fail).


% Read the row chosen by the user
% read_row(-Option)
read_row(Option) :-
    valid_row_options(ValidOptions),
    repeat,
    read_input([Input|_]),
    (member(Input, ValidOptions) -> Option = Input, !;
     write('Invalid Option. Please try again!\n'), fail).


% Read the user's answer in order to use the pie rule
% read_pie_rule(-Option)
read_pie_rule(Option) :-
    valid_boolean_answers(ValidOptions),
    repeat,
    read_input([Input|_]),
    (member(Input, ValidOptions) -> Option = Input, !;
     write('Invalid Option. Please try again!\n'), fail).
                          

% Read the input from the keyboard
% read_input(-Input)
read_input([Input|_]) :-
    get_code(Code),
    char_code(Input, Code),
    get_code(_),
    skip_line.
