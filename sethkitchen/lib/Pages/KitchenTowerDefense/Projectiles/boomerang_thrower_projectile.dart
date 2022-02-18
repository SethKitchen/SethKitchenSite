import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/projectile.dart';

class BoomerangThrowerProjectile extends Projectile {
  BoomerangThrowerProjectile(double x, double y, double attack, double speed,
      double rangeRadius, double angle)
      : super(
            projectileType: ProjectileType.boomerangThrower,
            x: x,
            y: y,
            attack: attack,
            speed: speed,
            rangeRadius: rangeRadius,
            angle: angle) {
    health = 3;
  }

  @override
  void move() {
    if (distanceTravelled > rangeRadius) {
      x -= speed * cos(angle - pi / 2);
      y -= speed * sin(angle - pi / 2);
    } else {
      x += speed * cos(angle - pi / 2);
      y += speed * sin(angle - pi / 2);
    }

    distanceTravelled += speed;

    if (distanceTravelled > 2 * rangeRadius) {
      isRemoved = true;
    }
  }

  @override
  Widget getImage() {
    return getBaseImage(Colors.orange);
  }
}
