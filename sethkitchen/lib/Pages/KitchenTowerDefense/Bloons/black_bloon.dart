import 'package:flutter/material.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/Bloons/pink_bloon.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/bloon.dart';

class BlackBloon extends Bloon {
  BlackBloon({required x, required y, required nodesPassed})
      : super(bloonType: BloonType.black, x: x, y: y, nodesPassed: nodesPassed) {
    health = 1;
    moneyValue = 10;
    speed *= 1.8;
    width = 50;
    height = 50;
    explosionImmunity = true;
  }

  @override
  Widget getImage() {
    return getBaseImage(width, height, Colors.black);
  }

  @override
  List<Bloon> breakIntoBloons() {
    List<Bloon> toReturn = [];
    toReturn.add(PinkBloon(x: x, y: y, nodesPassed: nodesPassed));
    toReturn.add(PinkBloon(x: x, y: y, nodesPassed: nodesPassed));
    return toReturn;
  }
}
