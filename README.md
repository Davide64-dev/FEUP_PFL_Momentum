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
In order to start the game, they first have to choose between playing, see the rules or exit. Then, to play the game they choose the first option. There they have to configurate the settings of the game, that includes choosing the game mode (Human VS. Human, Human VS. Computer and Computer VS. Computer) followed by the size of the game board (7 X 7, 7 X 9 and 9 X 9).
In the Human VS. Human mode the game begins after those choices. However, in the other modes the players still have to choose the level (Level 1 or Level 2) and which player starts first.
A possible interaction is represented in the image below.
(**insert image 2**)

In every option the input validation is secured. This happens not only on the menu options but in the input of the game play as well.

(**insert image 3**)
(**insert image 4**)



- ### Move Validation and Execution


- ### List of Valid Moves


- ### End of Game


- ### Game State Evaluation


- ### Computer plays


## Conclusions


## Bibliography