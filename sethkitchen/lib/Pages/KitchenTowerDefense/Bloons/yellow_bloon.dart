import 'package:flutter/material.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/Bloons/green_bloon.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/bloon.dart';

class YellowBloon extends Bloon {
  YellowBloon({required x, required y, required nodesPassed})
      : super(bloonType: BloonType.yellow, x: x, y: y, nodesPassed: nodesPassed) {
    health = 1;
    moneyValue = 5;
    speed *= 3.2;
    width = 50;
    height = 50;
  }

  @override
  Widget getImage() {
    return getBaseImage(width, height, Colors.yellow);
  }

  @override
  List<Bloon> breakIntoBloons() {
    List<Bloon> toReturn = [];
    toReturn.add(GreenBloon(x: x, y: y, nodesPassed: nodesPassed));
    return toReturn;
  }
}
