import 'package:flutter/material.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/Bloons/bfb_bloon.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/bloon.dart';

class ZOMGBloon extends Bloon {
  ZOMGBloon({required x, required y, required nodesPassed})
      : super(bloonType: BloonType.zomg, x: x, y: y, nodesPassed: nodesPassed) {
    health = 400;
    moneyValue = 400;
    speed *= 0.15;
    width = 120;
    height = 120;
    freezeImmunity = true;
    glueImmunity = true;
  }

  @override
  Widget getImage() {
    return getBaseImage(width, height, Colors.lightGreen);
  }

  @override
  void playPopNoise() {
    // MOABDamage.play();
  }

  @override
  List<Bloon> breakIntoBloons() {
    List<Bloon> toReturn = [];
    toReturn.add(BFBBloon(x: x, y: y, nodesPassed: nodesPassed));
    toReturn.add(BFBBloon(x: x, y: y, nodesPassed: nodesPassed));
    return toReturn;
  }
}
