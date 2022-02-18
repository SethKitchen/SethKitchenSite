import 'package:flutter/material.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/Bloons/black_bloon.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/bloon.dart';

class LeadBloon extends Bloon {
  LeadBloon({required x, required y, required nodesPassed})
      : super(bloonType: BloonType.lead, x: x, y: y, nodesPassed: nodesPassed) {
    health = 1;
    moneyValue = 12;
    speed *= 1;
    width = 50;
    height = 50;
    sharpImmunity = true;
  }

  @override
  Widget getImage() {
    return getBaseImage(width, height, Colors.grey);
  }

  @override
  void playPopNoise() {
    // metalBloonHit.play();
  }

  @override
  List<Bloon> breakIntoBloons() {
    List<Bloon> toReturn = [];
    toReturn.add(BlackBloon(x: x, y: y, nodesPassed: nodesPassed));
    toReturn.add(BlackBloon(x: x, y: y, nodesPassed: nodesPassed));
    return toReturn;
  }
}
