enum Direction { north, east, south, west }

void main() {
  // Initial position {7, 3} and facing north
  int x = 7;
  int y = 3;
  Direction direction = Direction.north;

  // Example instruction sequence
  const instructions = "RAALAL";

  // Function to turn right
  Direction turnRight(Direction dir) {
    switch (dir) {
      case Direction.north:
        return Direction.east;
      case Direction.east:
        return Direction.south;
      case Direction.south:
        return Direction.west;
      case Direction.west:
        return Direction.north;
    }
  }

  // Function to turn left
  Direction turnLeft(Direction dir) {
    switch (dir) {
      case Direction.north:
        return Direction.west;
      case Direction.east:
        return Direction.north;
      case Direction.south:
        return Direction.east;
      case Direction.west:
        return Direction.south;
    }
  }

  // Function to advance in the current direction
  void advance() {
    switch (direction) {
      case Direction.north:
        y += 1;
        break;
      case Direction.east:
        x += 1;
        break;
      case Direction.south:
        y -= 1;
        break;
      case Direction.west:
        x -= 1;
        break;
    }
  }

  // Process the instructions
  for (var command in instructions.split('')) {
    if (command == 'R') {
      direction = turnRight(direction);
    } else if (command == 'L') {
      direction = turnLeft(direction);
    } else if (command == 'A') {
      advance();
    }
  }

  // Print the final position and direction
  print("Final position: {$x, $y}");
  print("Facing: $direction");
}
