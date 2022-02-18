/* Projectile.dart
 	Seth Kitchen
	Class used to generate Projectile objects in the game that are shot by the Tower objects to pop the Bloon objects.
*/

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/bloon.dart';

enum ProjectileType {
  bombExploding,
  bombTower,
  boomerangThrower,
  dartMonkey,
  glueGunner,
  monkeyApprentice,
  ninjaMonkey,
  sniperMonkey,
  superMonkey,
  tackShooter
}

abstract class Projectile {
  //images for the different Projectile types
  Widget getImage();

  double x; //x pos of the Projectile (top left corner)
  double y; //y pos of the Projectile (top left corner)

  //Projectile stats
  ProjectileType projectileType;
  double attack;
  double width;
  double height;
  double speed;
  double rangeRadius;
  double distanceTravelled;
  double angle;
  double health;

  bool isRemoved; //determines if Projectile is removed
  bool
      isExploding; //determines if Projectile is currently exploding (only for bomb)

  //delay counter and tick to determine when bomb should be removed during explosion
  double explosionDelayCounter;
  final double explosionDelayTick = 5;

  //used to rotate Projectile
  //private AffineTransform saveXform;
  //private AffineTransform at;

  //SOUNDS
  // private Sound ceramicBloonHit = new Sound("Sounds/CeramicBloonHit.wav");
  // private Sound explosionBig = new Sound("Sounds/ExplosionBig.wav");
  //private Sound frozenBloonHit = new Sound("Sounds/FrozenBloonHit.wav");
  //private Sound metalBloonHit = new Sound("Sounds/MetalBloonHit.wav");
  //private Sound MOABDamage = new Sound("Sounds/MOABDamage.wav");
  //private Sound glueStrike = new Sound("Sounds/GlueStrike.wav");
  //private Sound pop = new Sound("Sounds/Pop1.wav");

  //CONSTUCTOR
  Projectile(
      {required this.projectileType,
      required this.x,
      required this.y,
      required this.attack,
      required this.speed,
      required this.rangeRadius,
      required this.angle})
      : width = 0,
        height = 0,
        distanceTravelled = 0,
        health = 1,
        isRemoved = false,
        isExploding = false,
        explosionDelayCounter = 0;

  Widget getBaseImage(Color color) {
    return Container(height: 2, width: 5, color: color);
  }

  //move() moves the Projectile
  void move() {
    x += speed * cos(angle - pi / 2);
    y += speed * sin(angle - pi / 2);

    distanceTravelled += speed;

    if (distanceTravelled > rangeRadius) {
      isRemoved = true;
    }
  }

  //checkIfExploding() is used to check when the bomb Projectile should
  //be removed during explosion
  void checkIfExploding() {}

  //checkForCollision() is used to check when the if the Projectile collided
  //with any Bloon objects
  List<Bloon> checkForCollision(List<Bloon> bloonsList) {
    for (Bloon b in bloonsList) {
      if (getRect().overlaps(b.getRect())) {
        //frozen Bloons are always affected by any Projectiles
        if (b.sharpImmunity == false || b.isFrozen == true) {
          health -= 1;
          b.health -= attack;
          if (health <= 0) {
            isRemoved = true;
          }
          if (b.health <= 0) {
            b.isRemoved = true;
          }
        }
        b.playPopNoise();
      }
    }
    return bloonsList;
  }

/*paint() draws the Bloon on the screen
  public

  void paint(Graphics2D g2) {
    saveXform = g2.getTransform();
    at = new AffineTransform();

    at.rotate(angle, x, y);
    g2.transform(at);

    if (projectileType.equals("bombTower") && isExploding == true) {
      g2.drawImage(
          bombExplodingImage, (double)(x - bombExplodingImage.getWidth(null) / 2),
          (double)(y - bombExplodingImage.getHeight(null) / 2), null);
    }
    else {
      g2.drawImage(
          getImage(), x - (double)(width / 2), y - (double)(height / 2), null);
    }

    g2.setTransform(saveXform);
  }
*/

//getRect() gets the Rect of the Projectile
  Rect getRect() {
    return Rect.fromLTWH(x, y, width, height);
  }
}
