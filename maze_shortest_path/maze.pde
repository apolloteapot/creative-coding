/*
0 = Left, 1 = Right, 2 = Up, 3 = Down
*/
IntList getDiggableDirections(int[][] maze, int row, int col)
{
  IntList res = new IntList();
  
  if (col > 1 && maze[row][col-1] == 1 && maze[row][col-2] == 1)  // Left
  {
    res.append(0);
  }
  
  if (col < maze[0].length - 2 && maze[row][col+1] == 1 && maze[row][col+2] == 1)  // Right
  {
    res.append(1);
  }
  
  if (row > 1 && maze[row-1][col] == 1 && maze[row-2][col] == 1)  // Up
  {
    res.append(2);
  }
  
  if (row < maze.length - 2 && maze[row+1][col] == 1 && maze[row+2][col] == 1)  // Down
  {
    res.append(3);
  }
  
  return res;
}


void DigTo(int[][] maze, int row, int col, int direction)
{
  maze[row][col] = 0;
  
  if (direction == 0)  // Left
  {
    maze[row][col-2] = 0;
    maze[row][col-1] = 0;
  }
  if (direction == 1)  // Right
  {
    maze[row][col+2] = 0;
    maze[row][col+1] = 0;
  }
  if (direction == 2)  // Up
  {
    maze[row-2][col] = 0;
    maze[row-1][col] = 0;
  }
  if (direction == 3)  // Down
  {
    maze[row+2][col] = 0;
    maze[row+1][col] = 0;
  }
}


void Dig(int[][] maze, int row, int col)
{
  IntList diggableDirections = getDiggableDirections(maze, row, col);
  
  while (diggableDirections.size() > 0)
  {
    int direction = diggableDirections.get(int(random(0, diggableDirections.size())));
    
    DigTo(maze, row, col, direction);
    
    if (direction == 0)
    {
      Dig(maze, row, col-2);
    }
    if (direction == 1)
    {
      Dig(maze, row, col+2);
    }
    if (direction == 2)
    {
      Dig(maze, row-2, col);
    }
    if (direction == 3)
    {
      Dig(maze, row+2, col);
    }
    
    diggableDirections = getDiggableDirections(maze, row, col);
  }
}


void OpenHoles(int[][] maze, float p)
{
  for (int row = 1; row < maze.length; row += 2) 
  {
    for (int col = 1; col < maze[0].length; col += 2) 
    {
      if (col > 1 && maze[row][col - 1] == 1)
      {
        if (random(1) <= p)
        {
          maze[row][col - 1] = 0;
        }
      }
      
      if (col < maze[0].length - 2 && maze[row][col + 1] == 1)
      {
        if (random(1) <= p)
        {
          maze[row][col + 1] = 0;
        }
      }
      
      if (row > 1 && maze[row - 1][col] == 1)
      {
        if (random(1) <= p)
        {
          maze[row - 1][col] = 0;
        }
      }
      
      if (row < maze.length - 2 && maze[row + 1][col] == 1)
      {
        if (random(1) <= p)
        {
          maze[row + 1][col] = 0;
        }
      }
    }
  }
}


/**
The size needs to be an odd number!
0 = Space, 1 = Wall
**/
int[][] createMaze(int size)
{
  int[][] maze = new int[size][size];

  for (int i = 0; i < size; i++) 
  {
    for (int j = 0; j < size; j++) 
    {
      maze[i][j] = 1;
    }
  }
  
  Dig(maze, 1, 1); // Start digging from top left
  
  OpenHoles(maze, 0.02);
  
  return maze;
}


void printMaze(int[][] maze)
{
  for (int i = 0; i < maze.length; i++) 
  {
    for (int j = 0; j < maze[0].length; j++) 
    {
      if (maze[i][j] == 0)
      {
        print(' ');
      }
      else
      {
        print('W');
      }
    }
    println();
  }
}


void drawMaze(int[][] maze)
{
  stroke(255, 255, 255);
  strokeWeight(2);
  
  for (int row = 0; row < maze.length; row += 2)
  {
    for (int col = 1; col < maze[0].length - 1; col += 2)
    {
      if (maze[row][col] == 1)
      {
        line(((col - 1) / 2) * SPACE_SIZE, (row / 2) * SPACE_SIZE, ((col + 1) / 2) * SPACE_SIZE, (row / 2) * SPACE_SIZE);
      }
    }
  }
  
  for (int row = 1; row < maze.length - 1; row += 2)
  {
    for (int col = 0; col < maze[0].length; col += 2)
    {
      if (maze[row][col] == 1)
      {
        line((col / 2) * SPACE_SIZE, ((row - 1) / 2) * SPACE_SIZE , (col / 2) * SPACE_SIZE, ((row + 1) / 2) * SPACE_SIZE);
      }
    }
  }
}


/*
A point on the screen
*/
class Point 
{
  float x, y;
  
  Point(float _x, float _y)
  {
    x = _x;
    y = _y;
  }
}


/*
Row and col on the maze matrix
*/
class Location 
{
  int row, col;
  
  Location(int _row, int _col)
  {
    row = _row;
    col = _col;
  }
}


Location pointToLocation(Point p)
{
  return new Location((floor(p.y / SPACE_SIZE) * 2) + 1, (floor(p.x / SPACE_SIZE) * 2) + 1);
}

Point locationToPoint(Location l)
{
  return new Point(((l.col - 1) / 2) * SPACE_SIZE + (SPACE_SIZE / 2), ((l.row - 1) / 2) * SPACE_SIZE + (SPACE_SIZE / 2));
}

Point getCenterPoint(Point p)
{
  return locationToPoint(pointToLocation(p));
}
