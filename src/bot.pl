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



% Define the find_best_move predicate for the smart bot
find_best_move(Board, SmartBotColor, Depth, BestMove) :-
    findall(Move, valid_move(Board, Move), AvailableMoves),
    best_move(Board, AvailableMoves, SmartBotColor, Depth, -9999, none, BestMove).


% Main predicate for finding the best move
best_move(_, [], _, _, BestScore, BestMove, BestMove) :- BestScore \= -9999.
best_move(_, [], _, _, _, BestMove, BestMove).

best_move(Board, [Move | RestMoves], SmartBotColor, Depth, CurrentBestScore, CurrentBestMove, BestMove) :-
    make_move(Board, Move, SmartBotColor, NewBoard),
    evaluate_board(NewBoard, SmartBotColor, Score),
    (Depth > 0 ->
        opponent_color(SmartBotColor, OpponentColor),
        minimax(NewBoard, Depth, OpponentColor, ScoreDiff)
    ; ScoreDiff = Score),
    NewScore is Score - ScoreDiff,
    (NewScore > CurrentBestScore ->
        best_move(Board, RestMoves, SmartBotColor, Depth, NewScore, Move, BestMove)
    ; best_move(Board, RestMoves, SmartBotColor, Depth, CurrentBestScore, CurrentBestMove, BestMove)
    ).

% Minimax search with alpha-beta pruning
minimax(Board, Depth, Player, Score) :-
    (Depth == 0 ; game_over(Board)),
    evaluate_board(Board, Player, Score).
