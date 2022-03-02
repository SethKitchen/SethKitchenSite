import 'package:a_star_algorithm/a_star_algorithm.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';
import 'package:sethkitchen/Pages/TowerDefense/actors/base_character.dart';
import 'package:sethkitchen/Pages/TowerDefense/game.dart';

class BaseEnemy extends BaseCharacter {
  late Vector2 velocity;
  final _collisionColor = Colors.amber;
  final _defaultColor = Colors.cyan;
  bool _isWallHit = false;
  bool _isCollision = false;
  KitchenDefenseGame game;

  BaseEnemy(Vector2 position, double width, double height, double initialHealth,
      {required this.game})
      : super(position, width, height, initialHealth);

  Offset getCurrentOffsetFromPosition() {
    return Offset((position.x / game.tileSize).floorToDouble(),
        (position.y / game.tileSize).floorToDouble());
  }

  Vector2 getVectorFromOffset(Offset tile) {
    return Vector2(tile.dx * game.tileSize, tile.dy * game.tileSize);
  }

  @override
  void update(double dt) {
    if (health == 0) {
      removeFromParent();
      return;
    }
    if (position == game.endPosition) {
      game.playerHealth -= health;
      removeFromParent();
      return;
    }
    debugColor = _isCollision ? _collisionColor : _defaultColor;
    Offset startOffset = getCurrentOffsetFromPosition();
    print('starting from');
    print(startOffset);
    final result = AStar(
      rows: 10,
      columns: 10,
      start: getCurrentOffsetFromPosition(),
      end: game.endPositionOffset,
      barriers: game.barriers,
    ).findThePath();
    Offset toGoTo = result.elementAt(1);
    print('going to');
    print(toGoTo);
    Vector2 toGoToVector = getVectorFromOffset(toGoTo);
    print(toGoToVector);
    velocity =
        Vector2(toGoToVector.x - position.x, toGoToVector.y - position.y);
    print('velocity');
    print(velocity);
    position.add(velocity * dt);
    _isCollision = false;
  }
}
