import 'package:flutter/material.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/projectile.dart';

class NinjaMonkeyProjectile extends Projectile {
  NinjaMonkeyProjectile(double x, double y, double attack, double speed,
      double rangeRadius, double angle)
      : super(
            projectileType: ProjectileType.ninjaMonkey,
            x: x,
            y: y,
            attack: attack,
            speed: speed,
            rangeRadius: rangeRadius,
            angle: angle);

  @override
  Widget getImage() {
    return getBaseImage(Colors.red);
  }
}
