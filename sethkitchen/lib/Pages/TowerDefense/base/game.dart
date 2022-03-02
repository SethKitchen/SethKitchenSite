import 'package:flame/game.dart';
import 'package:sethkitchen/Pages/TowerDefense/base/game_manager.dart';
import 'package:sethkitchen/Pages/TowerDefense/base/gameobject.dart';

abstract class BaseGame extends FlameGame {
  late BaseGameManager manager;
  Map<String, BaseGameObject> gameObjects = <String, BaseGameObject>{};
}
