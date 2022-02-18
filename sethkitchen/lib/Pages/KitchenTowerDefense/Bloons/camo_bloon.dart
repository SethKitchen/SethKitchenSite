import 'package:flutter/material.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/Bloons/pink_bloon.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/bloon.dart';

class CamoBloon extends Bloon {
  CamoBloon({required x, required y, required nodesPassed})
      : super(bloonType: BloonType.camo, x: x, y: y, nodesPassed: nodesPassed) {
    health = 1;
    moneyValue = 1;
    speed *= 1;
    width = 50;
    height = 50;
    detectionImmunity = true;
  }

  @override
  Widget getImage() {
    return getBaseImage(width, height, Colors.green.withOpacity(0.5));
  }

  @override
  List<Bloon> breakIntoBloons() {
    List<Bloon> toReturn = [];
    toReturn.add(PinkBloon(x: x, y: y, nodesPassed: nodesPassed));
    return toReturn;
  }
}
