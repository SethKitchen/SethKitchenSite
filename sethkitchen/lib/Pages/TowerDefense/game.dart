import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class KitchenDefenseGame extends FlameGame with HasCollidables, TapDetector {
  final double mapWidth;
  final double mapHeight;
  late double tileSize;
  double playerHealth = 100;

  KitchenDefenseGame({required this.mapWidth, required this.mapHeight});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(ScreenCollidable());
    tileSize = min(mapWidth, mapHeight);
    tileSize /= 20;
  }

  @override
  void onTapDown(TapDownInfo info) {}
}
