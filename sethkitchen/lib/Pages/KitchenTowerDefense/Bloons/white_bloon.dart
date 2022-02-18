import 'package:flutter/material.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/Bloons/pink_bloon.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/bloon.dart';

class WhiteBloon extends Bloon {
  WhiteBloon({required x, required y, required nodesPassed})
      : super(bloonType: BloonType.black, x: x, y: y, nodesPassed: nodesPassed) {
    health = 1;
    moneyValue = 10;
    speed *= 2;
    width = 50;
    height = 50;
    freezeImmunity = true;
  }

  @override
  Widget getImage() {
    return getBaseImage(width, height, Colors.white);
  }

  @override
  List<Bloon> breakIntoBloons() {
    List<Bloon> toReturn = [];
    toReturn.add(PinkBloon(x: x, y: y, nodesPassed: nodesPassed));
    toReturn.add(PinkBloon(x: x, y: y, nodesPassed: nodesPassed));
    return toReturn;
  }
}
