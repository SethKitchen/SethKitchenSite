import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:sethkitchen/Pages/TowerDefense/actors/base_enemy.dart';
import 'package:sethkitchen/Pages/TowerDefense/map/enemy_end_tile.dart';
import 'package:sethkitchen/Pages/TowerDefense/map/enemy_path_tile.dart';
import 'package:sethkitchen/Pages/TowerDefense/map/enemy_start_tile.dart';
import 'package:sethkitchen/Pages/TowerDefense/map/tile.dart';

class MyCrate extends SpriteComponent {
  // creates a component that renders the crate.png sprite, with size 16 x 16
  MyCrate() : super(size: Vector2.all(16));

  Future<void> onLoad() async {
    sprite = await Sprite.load('crate.png');
    anchor = Anchor.center;
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    // We don't need to set the position in the constructor, we can set it directly here since it will
    // be called once before the first time it is rendered.
    position = gameSize / 2;
  }
}

class KitchenDefenseGame extends FlameGame with HasCollidables, TapDetector {
  final double mapWidth;
  final double mapHeight;
  late Vector2 startPosition;
  late Offset startPositionOffset;
  late Vector2 endPosition;
  late Offset endPositionOffset;
  late List<Offset> barriers = [];
  late double tileSize;
  double playerHealth = 100;

  final List<String> levelOne = [
    "XXXXXXXXXS",
    "XOOOOOOOOO",
    "XOOOOOOOOO",
    "XOOOOOOOOO",
    "XXXXXXXXXX",
    "OOOOOOOOOX",
    "OOOOOOOOOX",
    "OOOOOOOOOX",
    "OOOOOOOOOX",
    "EXXXXXXXXX"
  ];

  KitchenDefenseGame({required this.mapWidth, required this.mapHeight});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(ScreenCollidable());
    tileSize = min(mapWidth, mapHeight);
    tileSize /= 20;

    for (int y = 0; y < levelOne.length; y++) {
      for (int x = 0; x < levelOne[y].length; x++) {
        Vector2 position =
            Vector2(x * tileSize + tileSize / 2, y * tileSize + tileSize / 2);
        double widthHeight = tileSize * 2;
        if (levelOne[y][x] == "X") {
          add(EnemyPathTile(position, widthHeight, widthHeight));
        } else if (levelOne[y][x] == "S") {
          add(EnemyStartTile(position, widthHeight, widthHeight));
          startPosition = position;
          startPositionOffset = Offset(x as double, y as double);
        } else if (levelOne[y][x] == "E") {
          add(EnemyEndTile(position, widthHeight, widthHeight));
          endPosition = position;
          endPositionOffset = Offset(x as double, y as double);
        } else {
          add(Tile(position, widthHeight, widthHeight));
          barriers.add(Offset(x as double, y as double));
        }
      }
    }
  }

  @override
  void onTapDown(TapDownInfo info) {
    print('adding base enemy @ ' + startPosition.toString());
    add(BaseEnemy(startPosition, tileSize * 2, tileSize * 2, 10, game: this));
  }
}
