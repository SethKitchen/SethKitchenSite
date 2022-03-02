import 'package:sethkitchen/Pages/TowerDefense/base/gameobject.dart';

enum TileDirection { north, east, south, west }

class BaseTile extends BaseGameObject {
  /// The X coordinate of the tile. */
  late num x;

  /// The Y coordinate of the tile. */
  late num y;

  /// The neighboring tile to the North, if present. */
  BaseTile? tileNorth;

  /// The neighboring tile to the East, if present. */
  BaseTile? tileEast;

  /// The neighboring tile to the South, if present. */
  BaseTile? tileSouth;

  /// The neighboring tile to the West, if present. */
  BaseTile? tileWest;

  BaseTile(BaseGameObjectData data, BaseGameObjectRequiredData requiredData)
      : super(data, requiredData);

  /// Gets the adjacent direction between this tile and an adjacent tile
  /// (if one exists).
  ///
  /// @param adjacentTile - A tile that should be adjacent to this tile.
  /// @returns - The string direction, or undefined if the
  /// tile is invalid, or there is no adjacent direction between this tile
  /// and that tile
  /// ("North", "East", "South", or "West") if found in that direction,
  /// undefined otherwise.
  TileDirection? getAdjacentDirection(BaseTile? adjacentTile) {
    if (adjacentTile != null) {
      for (final direction in TileDirection.values) {
        if (getNeighbor(direction) == adjacentTile) {
          return direction;
        }
      }
    }
    return null;
  }

  /// Gets a list of all the neighbors of this tile.
  ///
  /// @returns - An array of all adjacent tiles.
  /// Should be between 2 to 4 tiles.
  List<BaseTile> getNeighbors() {
    List<BaseTile> neighbors = [];

    for (final direction in TileDirection.values) {
      final neighbor = getNeighbor(direction);
      if (neighbor != null) {
        neighbors.add(neighbor);
      }
    }

    return neighbors;
  }

  /// Gets a neighbor in a particular direction.
  ///
  /// @param direction - The direction you want,
  /// must be "North", "East", "South", or "West".
  /// @returns The Tile in that direction, null if none.
  BaseTile? getNeighbor(TileDirection direction) {
    switch (direction) {
      case TileDirection.north:
        return tileNorth;
      case TileDirection.east:
        return tileEast;
      case TileDirection.south:
        return tileSouth;
      case TileDirection.west:
        return tileWest;
    }
  }

  /// Checks if a Tile has another tile as its neighbor.
  ///
  /// @param tile - Tile to check.
  /// @returns True if neighbor, false otherwise.
  bool hasNeighbor(BaseTile? tile) {
    return getAdjacentDirection(tile) != null;
  }

  /// ToString override.
  ///
  /// @returns A string representation of the Tile.
  @override
  String toString() {
    return "$gameObjectName #$id at ($x, $y)";
  }
}
