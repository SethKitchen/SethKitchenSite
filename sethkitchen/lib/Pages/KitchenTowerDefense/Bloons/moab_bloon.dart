import 'package:flutter/material.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/Bloons/ceramic_bloon.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/bloon.dart';

class MOABBloon extends Bloon {
  MOABBloon({required x, required y, required nodesPassed})
      : super(bloonType: BloonType.moab, x: x, y: y, nodesPassed: nodesPassed) {
    health = 200;
    moneyValue = 200;
    speed *= 1;
    width = 100;
    height = 100;
    freezeImmunity = true;
    glueImmunity = true;
  }

  @override
  Widget getImage() {
    return getBaseImage(width, height, Colors.blue);
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
