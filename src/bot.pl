:- use_module(library(random)).


easyBotMove(Board, BotColor, NewBoard) :-
    % Find all empty cells on the board.
    findEmptyCells(Board, EmptyCells),
    
    % If there are empty cells, choose one randomly and place the bot's piece.
    (EmptyCells = [] ->
        % If the board is full, return the same board.
        NewBoard = Board;
        random_member([X, Y], EmptyCells),
        putPiece(_Board, Row, Column, X, NewBoard)
    ).

