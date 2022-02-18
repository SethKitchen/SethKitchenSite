import 'package:flutter/material.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/Bloons/black_bloon.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/Bloons/white_bloon.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/bloon.dart';

class ZebraBloon extends Bloon {
  ZebraBloon({required x, required y, required nodesPassed})
      : super(bloonType: BloonType.zebra, x: x, y: y, nodesPassed: nodesPassed) {
    health = 1;
    moneyValue = 13;
    speed *= 1.8;
    width = 50;
    height = 50;
    explosionImmunity = true;
    freezeImmunity = true;
  }

  @override
  Widget getImage() {
    return getBaseImage(width, height, Colors.black38);
  }

  @override
  List<Bloon> breakIntoBloons() {
    List<Bloon> toReturn = [];
    toReturn.add(BlackBloon(x: x, y: y, nodesPassed: nodesPassed));
    toReturn.add(WhiteBloon(x: x, y: y, nodesPassed: nodesPassed));
    return toReturn;
  }
}
