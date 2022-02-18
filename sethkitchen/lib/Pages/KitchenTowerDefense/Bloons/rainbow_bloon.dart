import 'package:flutter/material.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/Bloons/zebra_bloon.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/bloon.dart';

class RainbowBloon extends Bloon {
  RainbowBloon({required x, required y, required nodesPassed})
      : super(bloonType: BloonType.rainbow, x: x, y: y, nodesPassed: nodesPassed) {
    health = 1;
    moneyValue = 15;
    speed *= 2.2;
    width = 50;
    height = 50;
  }

  @override
  Widget getImage() {
    return getBaseImage(width, height, Colors.purple);
  }

  @override
  List<Bloon> breakIntoBloons() {
    List<Bloon> toReturn = [];
    toReturn.add(ZebraBloon(x: x, y: y, nodesPassed: nodesPassed));
    toReturn.add(ZebraBloon(x: x, y: y, nodesPassed: nodesPassed));
    return toReturn;
  }
}
