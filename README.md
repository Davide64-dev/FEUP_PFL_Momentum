# Momentum

## Group Momentum_1
- Davide Pinto Teixeira - up202109860
- Maria Abreu da Costa - up202108849


## Instalation and Execution
To install the game it is necessary to download the PFL_TP1_T09_Momentum_1.zip and unzip it. Inside the src directory, we have the file menu.pl which we have to consult and then start the game by running the predicate play/0.

(**insert picture 1**) 

## Description of the game
In Momentum, players take turns dropping one of their counters on an empty cell of the game board. After that, we check in all the cells in a straight line in the 8 directions adjacent (vertically, horizontally and diagonally) to the dropped counter. The last counter of each of those lines is pushed one cell away from the dropped counter in that direction. If counters are pushed to the margin of the game board, then they are returned to their owner. In order to win the game, one player has to have all of his counters on the board at the end of his play.
During the second player's first turn in every game, they have the option to either place their counter on the board or swap out the counter that the first player placed with one of their own. If they choose to switch, the first player's counter is returned to them to be dropped again.
Additionally, the game offers three different board sizes: 7x7, 7x9, and 9x9. The number of counters allocated to each player varies according to the board size, with players receiving 8, 10, or 12 counters, respectively.
The rules of the game were obtained from (**insert names**)

## Game Logic


- ### Internal Game State Representation


- ### Game State Visualization
To initiate the game, players are presented with the options to "Play," "View Rules," or "Exit." Selecting "Play" allows them to configure the game settings, which includes choosing the game mode (Human VS. Human, Human VS. Computer or Computer VS. Computer), followed by the game board size (7x7, 7x9 or 9x9).
In Human VS. Human mode, the game commences after these choices. However, in the other modes, players further specify the level (Level 1 or Level 2) and determine which player starts the game.
A possible interaction is represented in the image below.
(**insert image 2**)

In every option the input validation is secured. This happens not only on the menu options but in the input of the game play as well.

(**insert image 3**)
(**insert image 4**)


- ### Move Validation and Execution


- ### List of Valid Moves
In each move, we validate whether it is valid. A move is considered valid if:
    - The selected cell falls within the size boundaries of the game board.
    - The chosen X and Y coordinates are greater than 0.
    - The selected cell is empty (white).

(**insert image of valid_moves**)

- ### End of Game
The game concludes when one of the players successfully places all of their counters on the game board. To determine this, a count of the counters within the board is performed after each move. If the count matches the total number of counters that each player initially possessed, than the player won the game.

- ### Game State Evaluation


- ### Computer plays
In the terms of the computer plays we used two strategies:
    - random, when playing in level 1, that as the name says, it chooses random values for the column and the row and checks if the move is valid.
    (**insert image of easy bot**)
    - greedy, when playing in level 2,  

## Conclusions
The game was developed with three distinct modes (Player vs. Player, Player vs. Computer, and Computer vs. Computer), along with three different board sizes (7x7, 7x9, and 9x9). The modes involving the Computer come with two levels of difficulty, adding significant diversity to the gameplay. Every user interaction is rigorously validated to ensure a smooth gaming experience.
The biggest difficulty was
The project provided a valuable opportunity to solidify our understanding of the concepts learned in our classes.

## Bibliography