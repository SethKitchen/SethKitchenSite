import 'package:flutter/material.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/Bloons/rainbow_bloon.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/bloon.dart';

class CeramicBloon extends Bloon {
  CeramicBloon({required x, required y, required nodesPassed})
      : super(bloonType: BloonType.ceramic, x: x, y: y, nodesPassed: nodesPassed) {
    health = 10;
    moneyValue = 0;
    speed *= 2.5;
    width = 50;
    height = 50;
    glueImmunity = true;
  }

  @override
  Widget getImage() {
    return getBaseImage(width, height, Colors.brown);
  }

  @override
  void playPopNoise() {
    // ceramicBloonHit.play();
  }

  @override
  List<Bloon> breakIntoBloons() {
    List<Bloon> toReturn = [];
    toReturn.add(RainbowBloon(x: x, y: y, nodesPassed: nodesPassed));
    toReturn.add(RainbowBloon(x: x, y: y, nodesPassed: nodesPassed));
    return toReturn;
  }
}
