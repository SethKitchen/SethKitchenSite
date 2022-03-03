import 'package:sethkitchen/Pages/TowerDefense/base/gameobject.dart';
import 'package:sethkitchen/Pages/TowerDefense/base/tiled.dart';

class BaseGameManager {
  final BaseGameObjectData bgod;
  final BaseGameObjectRequiredData bgord;

  BaseGameManager({required this.bgod, required this.bgord});

  BaseTile createTile(num x, num y) {
    return BaseTile(bgod, bgord);
  }
}
