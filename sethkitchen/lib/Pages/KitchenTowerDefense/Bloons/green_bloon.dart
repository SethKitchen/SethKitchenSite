import 'package:flutter/material.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/Bloons/blue_bloon.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/bloon.dart';

class GreenBloon extends Bloon {
  GreenBloon({required x, required y, required nodesPassed})
      : super(bloonType: BloonType.green, x: x, y: y, nodesPassed: nodesPassed) {
    health = 1;
    moneyValue = 4;
    speed *= 1.8;
    width = 50;
    height = 50;
  }

  @override
  Widget getImage() {
    return getBaseImage(width, height, Colors.green);
  }

  @override
  List<Bloon> breakIntoBloons() {
    List<Bloon> toReturn = [];
    toReturn.add(BlueBloon(x: x, y: y, nodesPassed: nodesPassed));
    return toReturn;
  }
}
