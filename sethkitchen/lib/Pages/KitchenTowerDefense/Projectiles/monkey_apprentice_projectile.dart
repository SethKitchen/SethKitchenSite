import 'package:flutter/material.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/bloon.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/projectile.dart';

class MonkeyApprenticeProjectile extends Projectile {
  MonkeyApprenticeProjectile(double x, double y, double attack, double speed,
      double rangeRadius, double angle)
      : super(
            projectileType: ProjectileType.monkeyApprentice,
            x: x,
            y: y,
            attack: attack,
            speed: speed,
            rangeRadius: rangeRadius,
            angle: angle) {
    health = 2;
  }

  //checkForCollision() is used to check when the if the Projectile collided
  //with any Bloon objects
  @override
  List<Bloon> checkForCollision(List<Bloon> bloonsList) {
    //Projectiles from super monkey and monkey apprentice can bypass sharp immunity
    for (Bloon b in bloonsList) {
      if (getRect().overlaps(b.getRect())) {
        health -= 1;
        b.health -= attack;
        if (health <= 0) {
          isRemoved = true;
        }
        if (b.health <= 0) {
          b.isRemoved = true;
        }

        b.playPopNoise();
      }
    }
    return bloonsList;
  }

  @override
  Widget getImage() {
    return getBaseImage(Colors.purple);
  }
}
