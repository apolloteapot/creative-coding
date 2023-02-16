int[][] maze = createMaze(151);
final int SCREEN_SIZE = 900;
final float SPACE_SIZE = SCREEN_SIZE / ((maze.length - 1) / 2);

void setup() 
{
  size(900, 900); // For some reason if I use the SCREEN_SIZE variable here I get an error
  rectMode(CENTER);
}

void draw()
{
  background(0);
  
  drawMaze(maze);
  
  Location mouseLocation = pointToLocation(new Point(mouseX, mouseY));  
  int[] spt = DijkstraSpt(maze, mouseLocation);
  drawPath(maze, getSp(spt, new Location(1, 1)));
  drawPath(maze, getSp(spt, new Location(1, maze[0].length - 2)));
  drawPath(maze, getSp(spt, new Location(maze.length - 2, 1)));
  drawPath(maze, getSp(spt, new Location(maze.length - 2, maze[0].length - 2)));
  
  fill(0, 0, 255);
  noStroke();
  Point center = locationToPoint(mouseLocation);
  circle(center.x, center.y, SPACE_SIZE * 0.8);
}
