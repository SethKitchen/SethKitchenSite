import 'package:flutter/material.dart';
import 'package:sethkitchen/Pages/KitchenTowerDefense/bloon.dart';

class RedBloon extends Bloon {
  RedBloon({required x, required y, required nodesPassed})
      : super(bloonType: BloonType.red, x: x, y: y, nodesPassed: nodesPassed) {
    health = 1;
    moneyValue = 2;
    speed *= 1;
    width = 50;
    height = 50;
  }

  @override
  Widget getImage() {
    return getBaseImage(width, height, Colors.red);
  }

  @override
  List<Bloon> breakIntoBloons() {
    return [];
  }
}
