import 'package:flutter/material.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/Bloons/ceramic_bloon.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/bloon.dart';

class BFBBloon extends Bloon {
  BFBBloon({required x, required y, required nodesPassed})
      : super(bloonType: BloonType.bfb, x: x, y: y, nodesPassed: nodesPassed) {
    health = 300;
    moneyValue = 300;
    speed *= 0.25;
    width = 100;
    height = 100;
    freezeImmunity = true;
    glueImmunity = true;
  }

  @override
  Widget getImage() {
    return getBaseImage(width, height, Colors.red);
  }

  @override
  void playPopNoise() {
    // MOABDamage.play();
  }

  @override
  List<Bloon> breakIntoBloons() {
    List<Bloon> toReturn = [];
    toReturn.add(CeramicBloon(x: x, y: y, nodesPassed: nodesPassed));
    toReturn.add(CeramicBloon(x: x, y: y, nodesPassed: nodesPassed));
    return toReturn;
  }
}
