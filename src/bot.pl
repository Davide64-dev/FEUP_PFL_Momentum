:- use_module(library(random)).

easyBotMove(State, Board, BotColor, NewBoard, 1) :-
    repeat,
    (
        random(1, 8, Row),
        random(1, 8, Column),
        validate_move(Board, Row, Column),
        move(Board, Row, Column, BotColor, NewBoard)
    ).

easyBotMove(State, Board, BotColor, NewBoard, 2) :-
    pie_rule('y', State, Board, BotColor, NewBoard).

hardBotMove(Board, BotColor, NewBoard) :-
    countCells(Board, BotColor, Reference),
    repeat,
    (
        random(1, 8, Row),
        random(1, 8, Column),
        validate_move(Board, Row, Column),
        move(Board, Row, Column, BotColor, TempBoard),
        countCells(TempBoard, BotColor, Temp),
        Temp > Reference,
        move(Board, Row, Column, BotColor, NewBoard)
    ).


choose_move(State, Board, BotColor, NewBoard, '1', Y) :- Y\= 2, write('The bot is playing...\n'), easyBotMove(State, Board, BotColor, NewBoard, 1).

choose_move(State, Board, BotColor, NewBoard, '1', 2) :- random(1, 3, X), write('The bot is playing...\n'), easyBotMove(State, Board, BotColor, NewBoard, X).

choose_move(State, Board, BotColor, NewBoard, '2', Y) :- write('The hard bot is playing...\n'), hardBotMove(Board, BotColor, NewBoard).

