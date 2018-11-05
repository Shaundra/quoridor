# Quoridor
[Quoridor](http://en.gigamic.com/game/quoridor) is an abstract strategy game. Played on a grid, your object is to make it through the labyrinths your opponent creates to get to the other side. This is a CLI-based reproduction of the game. 

## Running the Game
To play Quoridor, run `./bin/quoridor` from the command line. After confirming that you'd like to play, the game will prompt you to choose a grid size and have the first player choose their token. The game board will then render with players in their starting positions.

```
>> ./bin/quoridor

Hi! Welcome to Quoridor on the command line!
Would you like to play? Y/n
y

Level of difficulty? Choose grid size 5 or 9.
5
What's player 1's token? Choose X or O
X
And player 2's token is O
```

```
    0 1 2 3 4 5 6 7 8
   - - - - - - - - - -
0 :   |   | X |   |   
1 :-------------------
2 :   |   |   |   |   
3 :-------------------
4 :   |   |   |   |   
5 :-------------------
6 :   |   |   |   |   
7 :-------------------
8 :   |   | O |   |   
```
## Playing the Game
Once you've instantiated a new Quoridor game, game play is kicked off and Player 1 is asked how they'd like to move. Play will alternate between players, with each turn consisting of either moving your pawn or placing a fence.

```
     0 1 2 3 4 5 6 7 8
    - - - - - - - - - -
 0 :   |   | X |   |   
 1 :-------------------
 2 :   |   |   |   |   
 3 :-------------------
 4 :   |   |   |   |   
 5 :-------------------
 6 :   |   |   |   |   
 7 :-------------------
 8 :   |   | O |   |   
Player X (Fence count: 10), it's your turn!
Would you like to move your pawn or place a fence? Type pawn or fence.
pawn
Where would you like to move? Use the board guide to choose row, column coordinates. Ex. 2, 4
2, 4

    0 1 2 3 4 5 6 7 8
   - - - - - - - - - -
0 :   |   |   |   |   
1 :-------------------
2 :   |   | X |   |   
3 :-------------------
4 :   |   |   |   |   
5 :-------------------
6 :   |   |   |   |   
7 :-------------------
8 :   |   | O |   |   
```

## Next Steps
Subsequent updates to Quoridor will:
- [ ] implement `#jump` method
- [ ] implement `#blocks_baseline?` check
- [ ] update fence length (x2) for 9x9 games
- [ ] write tests
