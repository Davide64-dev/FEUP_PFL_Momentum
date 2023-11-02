valid_boolean_answers(['y', 'n']).


%Prints an option from the menu and submenu
%print_option(+Key, +Text)
print_option(Key, Text) :-
    format('~w. ~w\n', [Key, Text]).


%Reads the option chosen by the user
%read_option(+Option)
read_option(Option) :-
    valid_menu_options(ValidOptions),
    repeat,
    read_input([Input|_]),
    (member(Input, ValidOptions) -> Option = Input, !;
     write('Invalid Option. Please try again!\n'), fail).

read_column(Option) :-
    valid_column_options(ValidOptions),
    repeat,
    read_input([Input|_]),
    (member(Input, ValidOptions) -> Option = Input, !;
     write('Invalid Option. Please try again!\n'), fail).

read_row(Option) :-
    valid_row_options(ValidOptions),
    repeat,
    read_input([Input|_]),
    (member(Input, ValidOptions) -> Option = Input, !;
     write('Invalid Option. Please try again!\n'), fail).

read_pie_rule(Option) :-
    valid_boolean_answers(ValidOptions),
    repeat,
    read_input([Input|_]),
    (member(Input, ValidOptions) -> Option = Input, !;
     write('Invalid Option. Please try again!\n'), fail).
    
                        

%Reads the input from the keyboard
%read_input([Input|_])
read_input([Input|_]) :-
    get_code(Code),
    char_code(Input, Code),
    get_code(_),
    skip_line.

                  