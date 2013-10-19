#TWMazeGenerator

##Overview

A basic implementation of the depth first backtracking maze generation
algorithm. Effors are being made to allow this to be extended and used
by other algorithms.

There is still work to be done in order to make this fully reusable for other
algorithms but not a great deal.

##Classes

###TWTile
A simple node which information about an individual tile in a maze.
This includes weather the tile has been visited, it's posistion in the
mazes grid and it's neighboring tiles.

It neighboring tiles are in an array called walls. Neighbors in this
array are blocked by a wall.

Holds a public method to see in which direction a position is from another.

###TWMaze
When initialise with a size, a TWMaze creates a graph of TWTiles and
places them in a NSMutableArray. As a path is built this is tiles are
placed in the path NSMutableArray

###TWMazeGenerator
This class runs the process of initiallising the algorithm and running
it. It holds reference to an id object that follows the TWPathFinder
protocol which creates the mazes path.

###TWDepthFirstPathFinder
Following a simple protocol <TWPathFinder> this holds the actual algorithm
which creates the maze.

##Example
So far no example has been made, how ever you can see the algorithm in use
at [DungeonStyleGame](https://github.com/bloggertom/DungeonGame) where an 
earlier version of these classes are used to generate a map.
