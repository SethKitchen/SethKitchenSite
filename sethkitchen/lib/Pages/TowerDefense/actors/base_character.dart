import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';
import 'package:sethkitchen/Pages/TowerDefense/game.dart';

class BaseCharacter extends PositionComponent
    with HasGameRef<KitchenDefenseGame>, HasHitboxes, Collidable {
  late Vector2 velocity;
  final _collisionColor = Colors.amber;
  final _defaultColor = Colors.cyan;
  bool _isCollision = false;
  double health = 0;

  BaseCharacter(
      Vector2 position, double width, double height, double initialHealth)
      : super(
          position: position,
          size: Vector2(width, height),
          anchor: Anchor.center,
        ) {
    health = initialHealth;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    addHitbox(HitboxRectangle());
    velocity = Vector2(0, 0);
  }

  @override
  void update(double dt) {
    if (health == 0) {
      removeFromParent();
      return;
    }
    debugColor = _isCollision ? _collisionColor : _defaultColor;
    _isCollision = false;
  }

  @override
  void render(Canvas canvas) {
    Paint p = Paint();
    p.color = debugColor;
    p.style = PaintingStyle.fill;
    renderHitboxes(canvas, paint: p);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    _isCollision = true;
  }
}
