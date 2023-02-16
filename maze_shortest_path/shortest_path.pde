int locationToVertex(int[][] maze, Location location)
{
  return ((location.row - 1) / 2) * ((maze[0].length - 1) / 2) + ((location.col - 1) / 2);
}

Location vertexToLocation(int[][] maze, int vertex)
{
  return new Location((floor(vertex / ((maze[0].length - 1) / 2)) * 2) + 1, ((vertex * 2) + 1) % (maze[0].length - 1));
}


int[][] mazeToAdjMatrix(int[][] maze)
{
  int nVertices = ((maze.length - 1) / 2) * (maze[0].length - 1) / 2;
  
  int[][] adjMatrix = new int[nVertices][nVertices];
  
  for (int row = 1; row < maze.length; row += 2)
  {
    for (int col = 1; col < maze[0].length; col += 2)
    {
      int vertex = locationToVertex(maze, new Location(row, col));
      IntList adjVertices = new IntList();
      
      if (maze[row][col - 1] == 0)
      {
        adjVertices.append(locationToVertex(maze, new Location(row, col - 2)));
      }
      
      if (maze[row][col + 1] == 0)
      {
        adjVertices.append(locationToVertex(maze, new Location(row, col + 2)));
      }
      
      if (maze[row - 1][col] == 0)
      {
        adjVertices.append(locationToVertex(maze, new Location(row - 2, col)));
      }
      
      if (maze[row + 1][col] == 0)
      {
        adjVertices.append(locationToVertex(maze, new Location(row + 2, col)));
      }
      
      for (int adjVertex : adjVertices)
      {
        adjMatrix[vertex][adjVertex] = 1;
        adjMatrix[adjVertex][vertex] = 1;
      }
    }
  }
  
  return adjMatrix;
}


int[] DijkstraSpt(int[][] maze, Location src)
{
  int[][] adjMatrix = mazeToAdjMatrix(maze);
  int srcV = locationToVertex(maze, src);
  
  int[] dist = new int[adjMatrix.length];
  boolean[] visited = new boolean[adjMatrix.length];
  int[] spt = new int[adjMatrix.length];
  
  int maxDist = (maze.length - 1) / 2 * (maze[0].length - 1) / 2; // Infinity
  
  // Initialise dist, visited, spt
  
  for (int v = 0; v < dist.length; v++)
  { 
    if (v == srcV)
    {
      dist[v] = 0;
    }
    else
    {
      dist[v] = maxDist;
    }
    
    visited[v] = false;
    spt[v] = -1;
  }
  
  // Visit every node one by one
  
  for (int i = 0; i < dist.length; i++)
  {
    // Get the vertex with the min distance and not visited
    int minV = -1;
    int minDist = maxDist;
    
    for (int v = 0; v < dist.length; v++)
    {
      if (!visited[v] && dist[v] < minDist)
      {
        minDist = dist[v];
        minV = v;
      }
    }
    
    // Set the found vertex to visited
    visited[minV] = true;
    
    // Update distances of adjacent vertices and spt
    for (int y = 0; y < dist.length; y++)
    {
      if (adjMatrix[minV][y] > 0 && !visited[y] && dist[y] > dist[minV] + adjMatrix[minV][y])
      {
        dist[y] = dist[minV] + adjMatrix[minV][y];
        spt[y] = minV;
      }
    }
  }
  
  return spt;
}


IntList getSp(int[] spt, Location dest)
{
  int destV = locationToVertex(maze, dest);
  int current = destV;
  IntList sp = new IntList();
  sp.append(current);
  
  while (spt[current] >= 0)
  {
    current = spt[current];
    sp.append(current);
  }
  
  sp.reverse();
  return sp;
}


void drawPath(int[][] maze, IntList path)
{
  fill(255, 0, 0);
  noStroke();
  Point p = null;
  
  for (int vertex : path)
  {
    p = locationToPoint(vertexToLocation(maze, vertex));
    rect(p.x, p.y, SPACE_SIZE * 0.8, SPACE_SIZE * 0.8);
  }
}
