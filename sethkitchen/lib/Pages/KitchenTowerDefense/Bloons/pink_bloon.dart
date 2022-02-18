import 'package:flutter/material.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/Bloons/yellow_bloon.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/bloon.dart';

class PinkBloon extends Bloon {
  PinkBloon({required x, required y, required nodesPassed})
      : super(bloonType: BloonType.pink, x: x, y: y, nodesPassed: nodesPassed) {
    health = 1;
    moneyValue = 6;
    speed *= 3.5;
    width = 50;
    height = 50;
  }

  @override
  Widget getImage() {
    return getBaseImage(width, height, Colors.pink);
  }

  @override
  List<Bloon> breakIntoBloons() {
    List<Bloon> toReturn = [];
    toReturn.add(YellowBloon(x: x, y: y, nodesPassed: nodesPassed));
    return toReturn;
  }
}
