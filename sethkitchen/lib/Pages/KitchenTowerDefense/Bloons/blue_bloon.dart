import 'package:flutter/material.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/Bloons/red_bloon.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/bloon.dart';

class BlueBloon extends Bloon {
  BlueBloon({required x, required y, required nodesPassed})
      : super(bloonType: BloonType.blue, x: x, y: y, nodesPassed: nodesPassed) {
    health = 1;
    moneyValue = 3;
    speed *= 1.4;
    width = 50;
    height = 50;
  }

  @override
  Widget getImage() {
    return getBaseImage(width, height, Colors.blue);
  }

  @override
  List<Bloon> breakIntoBloons() {
    List<Bloon> toReturn = [];
    toReturn.add(RedBloon(x: x, y: y, nodesPassed: nodesPassed));
    return toReturn;
  }
}
