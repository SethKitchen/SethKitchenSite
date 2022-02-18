import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/projectile.dart';

class SniperMonkeyProjectile extends Projectile {
  SniperMonkeyProjectile(double x, double y, double attack, double speed,
      double rangeRadius, double angle)
      : super(
            projectileType: ProjectileType.sniperMonkey,
            x: x,
            y: y,
            attack: attack,
            speed: speed,
            rangeRadius: rangeRadius,
            angle: angle);

  @override
  void move() {
    x += speed * cos(angle - pi / 2);
    y += speed * sin(angle - pi / 2);

    distanceTravelled += speed;

    //remove sniper monkey Projectile if it reached end of track
    if (!getRect()
        .overlaps(const Rect.fromLTWH(0 - 50, 0 - 50, 775 + 50, 570 + 50))) {
      isRemoved = true;
    }
  }

  @override
  Widget getImage() {
    return getBaseImage(Colors.green);
  }
}
