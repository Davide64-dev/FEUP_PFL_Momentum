# Momentum

## Group Momentum_1
- Davide Pinto Teixeira - up202109860
- Maria Abreu da Costa - up202108849


## Instalation and Execution
To install the game it is necessary to download the PFL_TP1_T09_Momentum_1.zip and unzip it. Inside the src directory, we have the file play.pl which we have to consult and then start the game by running the predicate play/0. To run the game, you can use the following commands:

```
consult('play.pl').
play.
```

## Description of the game
In [Momentum](https://boardgamegeek.com/boardgame/73091/momentum/files), players take turns dropping one of their counters on an empty cell of the game board. After that, we check in all the cells in a straight line in the 8 directions adjacent (vertically, horizontally and diagonally) to the dropped counter. The last counter of each of those lines is pushed one cell away from the dropped counter in that direction. If counters are pushed to the margin of the game board, then they are returned to their owner. In order to win the game, one player has to have all of his counters on the board at the end of his play.
During the second player's first turn in every game, they have the option to either place their counter on the board or swap out the counter that the first player placed with one of their own. If they choose to switch, the first player's counter is returned to them to be dropped again.
Additionally, the game offers three different board sizes: 7x7, 7x9, and 9x9. The number of counters allocated to each player varies according to the board size, with players receiving 8, 10, or 12 counters, respectively.
The rules of the game were obtained from (**insert names**)

## Game Logic


- ### Internal Game State Representation

The Game State is represented by several parameters, such as:

- The Board game, it is maybe the most important piece of the game,
- The User that is playing (red or blue). The game always starts with the blue color.
- The round that is taking place

Depending on the game mode we can have

- The level(s) of the bot.
- Who plays first (in case of player vs computer)


- ### Game State Visualization
To initiate the game, players are presented with the options to "Play," "View Rules," or "Exit." Selecting "Play" allows them to configure the game settings, which includes choosing the game mode (Human VS. Human, Human VS. Computer or Computer VS. Computer), followed by the game board size (7x7, 7x9 or 9x9).
In Human VS. Human mode, the game commences after these choices. However, in the other modes, players further specify the level (Level 1 or Level 2) and determine which player starts the game.
A possible interaction is represented in the image below.

![Alt text](img/menu_interaction.png)

Then during the game, the state of the game is displayed by using a predicate `display_game` that prints the board

![Alt text](img/board.png)

For creating the initial state of the game, we have a predicate`initial_state` that creates the first board, the empty one.

![Alt text](img/initial_state.png)


- ### Move Validation and Execution

When executing a move, it is necessary to garantee that that move is valid in the conext of that game state and the rules. With that we implemented a predicate `initial_state` taht is responsible for doing that validation. The rules says that every time a user wans to put a cell, that cell must be empty, represented in our game as `white` and that it cannot be on the boarders of the board, with that in mind, this predicate was created

![Alt text](img/validate_move.png)


- ### List of Valid Moves

With that, a predicate called `valid_moves`was created that has the only purpose to, inside of the board, return a list of all possible cells where a user can put his piece.

- ### End of Game
The game concludes when one of the players successfully places all of their counters on the game board. To determine this, a count of the counters within the board is performed after each move. If the count matches the total number of counters that each player initially possessed, than the player won the game. That is represented with the predicate `game_over` which verifies, as the rules said, after each round where a user puts a cell, verifies if that user has already all of his cells in the board. If yes, the game finishes and that user is the winner, if not, the game continues.

- ### Game State Evaluation

The game state is evaluated with a apremeter that counts the round number of the game.

- ### Computer plays
    In the terms of the computer plays we used two strategies:
    - random, when playing in level 1, that as the name says, it chooses random values for the column and the row and checks if the move is valid. 
    - greedy, when playing in level 2.

## Conclusions
The game was developed with three distinct modes (Player vs. Player, Player vs. Computer, and Computer vs. Computer), along with three different board sizes (7x7, 7x9, and 9x9). The modes involving the Computer come with two levels of difficulty, adding significant diversity to the gameplay. Every user interaction is rigorously validated to ensure a smooth gaming experience.
The biggest difficulty was the code organization, which is the feature that obviously could be imporved.
The project provided a valuable opportunity to solidify our understanding of the concepts learned in our classes about Logical Porgramming.

## Bibliography

[Sicstus Prolog Homepage](https://sicstus.sics.se/documentation.html)

[Momentum Board Game Page](https://boardgamegeek.com/boardgame/73091/momentum)

