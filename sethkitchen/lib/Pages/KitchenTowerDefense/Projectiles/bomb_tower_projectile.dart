import 'package:flutter/material.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/bloon.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/projectile.dart';

class BombTowerProjectile extends Projectile {
  BombTowerProjectile(double x, double y, double attack, double speed,
      double rangeRadius, double angle)
      : super(
            projectileType: ProjectileType.bombTower,
            x: x,
            y: y,
            attack: attack,
            speed: speed,
            rangeRadius: rangeRadius,
            angle: angle);

  //checkIfExploding() is used to check when the bomb Projectile should
  //be removed during explosion
  @override
  void checkIfExploding() {
    if (isExploding == true) {
      explosionDelayCounter++;
      if (explosionDelayCounter == explosionDelayTick) {
        isRemoved = true;
      }
    }
  }

  //checkForCollision() is used to check when the if the Projectile collided
  //with any Bloon objects
  @override
  List<Bloon> checkForCollision(List<Bloon> bloonsList) {
    for (Bloon b in bloonsList) {
      if (getRect().overlaps(b.getRect())) {
        //damage all Bloons within range for bomb Projectile
        if (b.explosionImmunity == false) {
          isExploding = true;
          Rect bombRect = Rect.fromLTWH((x - 50 / 2), (y - 50 / 2), 50, 50);
          if (bombRect.overlaps(b.getRect())) {
            b.health -= attack;
            if (b.health <= 0) {
              b.isRemoved = true;
            }
          }
          //explosionBig.play();
        }
      }
    }
    return bloonsList;
  }

  @override
  Widget getImage() {
    return getBaseImage(Colors.black);
  }
}
