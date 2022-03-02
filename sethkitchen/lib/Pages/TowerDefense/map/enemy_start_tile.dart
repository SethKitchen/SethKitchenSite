import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:sethkitchen/Pages/TowerDefense/map/tile.dart';

class EnemyStartTile extends Tile {
  EnemyStartTile(Vector2 position, double width, double height)
      : super(position, width, height) {
    tileColor = Colors.lightBlue;
  }
}
