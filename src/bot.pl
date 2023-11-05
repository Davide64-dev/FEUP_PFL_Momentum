:- use_module(library(random)).

easyBotMove(Board, BotColor, NewBoard, 1) :-
    repeat,
    (
        random(1, 8, Row),
        random(1, 8, Column),
        (
          validate_move(Board, Row, Column) -> 
          putPiece(Board, Row, Column, BotColor, NewBoard),
          !; 
          nl
        )
    ).

easyBotMove(Board, BotColor, NewBoard, 2) :-
    pie_rule('y', pvc, Board, BotColor, NewBoard).


hardBotMove(Board, BotColor, NewBoard) :-
    % Find all valid moves, sorted by distance from the center of the board.
    ValidMoves = maplist(distance, Board, BotColor),
    ksort(ValidMoves, [(BestDistance, _, _)|_]),

    % Put a piece on the best move.
    putPiece(BestDistance, Board, BotColor, NewBoard).

distance(Board, Row, Column, Distance) :- distance_from_center(Row, Column, Distance), validate_move(Board, Row, Column).


distance_from_center(Row, Column, Distance) :-
    CenterRow is 4, % Assuming the center of the 8x8 board is at row 4
    CenterColumn is 4, % Assuming the center of the 8x8 board is at column 4
    Distance is abs(CenterRow - Row) + abs(CenterColumn - Column).

    
    

botMove(Board, BotColor, NewBoard, '1', Y) :- Y\= 2, write('The bot is playing...\n'), easyBotMove(Board, BotColor, NewBoard, 1).

botMove(Board, BotColor, NewBoard, '1', 2) :- random(1, 3, X), write('The bot is playing...\n'), easyBotMove(Board, BotColor, NewBoard, X).

botMove(Board, BotColor, NewBoard, '2', Y) :- write('The bot is playing...\n'), hardBotMove(Board, BotColor, NewBoard).

