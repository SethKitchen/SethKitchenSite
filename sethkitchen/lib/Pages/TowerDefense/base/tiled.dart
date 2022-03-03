import 'dart:math';

import 'package:sethkitchen/Pages/TowerDefense/base/game.dart';
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

/// A game that has a map made of tiles in it. */
class TiledGame extends BaseGame {
  // client <--> server properties
  /// The tiles in the game, in rowMajor order. */
  final List<BaseTile> tiles;

  /// The width of the map along the X-Axis. */
  final num mapWidth;

  /// The height of the map along the Y-Axis. */
  final num mapHeight;

  // server-side only
  /// The valid directions tiles can be in from one another. */

  // any[] is required for mixin constructor signature
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  TiledGame(
      {required this.mapWidth, required this.mapHeight, this.tiles = const []})
      : super() {
    // Create each tile.
    for (num x = 0; x < mapWidth; x++) {
      for (num y = 0; y < mapHeight; y++) {
        final i = x + y * mapWidth;
        tiles[i.toInt()] = manager.createTile(x, y);
      }
    }

    // now hook up their neighbors
    for (num x = 0; x < mapWidth; x++) {
      for (num y = 0; y < mapHeight; y++) {
        final tile = getTile(x, y);

        tile?.tileNorth = getTile(x, y - 1);
        tile?.tileEast = getTile(x + 1, y);
        tile?.tileSouth = getTile(x, y + 1);
        tile?.tileWest = getTile(x - 1, y);
      }
    }
  }

  /// Gets the tile at (x, y), or undefined if the co-ordinates are
  /// off-map.
  ///
  /// @param x - The x position of the desired tile.
  /// @param y - The y position of the desired tile.
  /// @returns The Tile at (x, y) if valid, null otherwise.
  BaseTile? getTile(num x, num y) {
    if (x < 0 || x >= mapWidth || y < 0 || y >= mapHeight) {
      return null;
    }

    return tiles[(x + y * mapWidth).toInt()];
  }

  /// Given the index in the tiles array, gets the (x, y) of that tile.
  ///
  /// @param index - The index to get.
  /// @returns A point with the { x, y } value at that index's point.
  Point getIndex(num index) {
    final y = index / mapWidth;
    final x = index - y * mapWidth;

    return Point(x, y);
  }

  /// Inverts a direction string, e.g. "North" -> "South".
  ///
  /// @param direction - The direction string to invert.
  /// @returns The direction inverted,
  /// e.g. "East" -> "West", undefined if the direction was not a valid
  /// direction string.
  TileDirection invertTileDirection(TileDirection direction) {
    switch (direction) {
      case TileDirection.east:
        return TileDirection.west;
      case TileDirection.north:
        return TileDirection.south;
      case TileDirection.south:
        return TileDirection.north;
      case TileDirection.west:
        return TileDirection.east;
    }
  }
}
