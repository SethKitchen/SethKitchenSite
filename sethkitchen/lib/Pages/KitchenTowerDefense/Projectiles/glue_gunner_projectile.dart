import 'package:flutter/material.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/bloon.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/projectile.dart';

class GlueGunnerProjectile extends Projectile {
  GlueGunnerProjectile(double x, double y, double attack, double speed,
      double rangeRadius, double angle)
      : super(
            projectileType: ProjectileType.glueGunner,
            x: x,
            y: y,
            attack: attack,
            speed: speed,
            rangeRadius: rangeRadius,
            angle: angle);

  //checkForCollision() is used to check when the if the Projectile collided
  //with any Bloon objects
  @override
  List<Bloon> checkForCollision(List<Bloon> bloonsList) {
    for (Bloon b in bloonsList) {
      if (getRect().overlaps(b.getRect())) {
        //slow down Bloon for glue Projectile
        if (b.glueImmunity == false) {
          b.isGlued = true;
          // glueStrike.play();
        }
      }
    }
    return bloonsList;
  }

  @override
  Widget getImage() {
    return getBaseImage(Colors.white);
  }
}
