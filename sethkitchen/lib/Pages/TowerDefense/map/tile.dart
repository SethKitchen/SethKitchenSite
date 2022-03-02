import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';
import 'package:sethkitchen/Pages/TowerDefense/game.dart';

class Tile extends PositionComponent with HasGameRef<KitchenDefenseGame> {
  Color tileColor = Colors.black;

  Tile(Vector2 position, double width, double height)
      : super(
          position: position,
          size: Vector2(width, height),
          anchor: Anchor.center,
        );

  @override
  void render(Canvas canvas) {
    Paint p = Paint();
    p.color = tileColor;
    p.style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(position.x, position.y, width, height), p);
  }
}
