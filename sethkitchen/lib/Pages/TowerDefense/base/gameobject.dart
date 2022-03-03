import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:sethkitchen/Pages/TowerDefense/base/game.dart';
import 'package:sethkitchen/Pages/TowerDefense/base/game_manager.dart';

/// 16kb should be enough for any log, and may still be too large. */
const maxLogLength = 16 * 1024;

/// The base game object data (empty). */
class BaseGameObjectData {
  // pass
}

/// Values required by all game objects to be initialized correctly. */
class BaseGameObjectRequiredData {
  /// The id of the game object. */
  final String id;

  /// The name of the class this GameObject is. */
  final String gameObjectName;

  /// The game this game object is in. */
  final BaseGame game;

  BaseGameObjectRequiredData(
      {required this.id, required this.gameObjectName, required this.game});
}

/// The base object for any object in the game that will need to be tracked via
/// an ID, e.g. Players, units, etc.
class BaseGameObject extends Component {
  /// The ID of the game object. */
  late String id;

  /// The top class name of the game object. */
  late String gameObjectName;

  /// The logs logged to this game object. */
  late List<String> logs;

  /// The game this game object is in.
  /// Inheriting classes should specify the sub game type.
  late BaseGame game;

  /// The manager that manages actions around the game this game object is in.
  late BaseGameManager manager;

  /// Creates a base game object with some initialization data.
  ///
  /// @param data - The initialization data use by the super class.
  /// @param requiredData - The data required to hook up this game object
  /// the game, and set default values for the sub class.
  BaseGameObject({
    required this.id,
    required this.gameObjectName,
  }) : super() {
    game = requiredData.game;
    manager = game.manager;
    game.gameObjects[id] = this;
  }

  /// String coercion override, handles players by default as every game has
  /// them.
  ///
  /// @returns Formatted string for this name.
  @override
  String toString() {
    return "$gameObjectName #$id";
  }

  /// Logs a string to this BaseGameObject's log array, for debugging
  /// purposes.
  /// This is called from a 'run' event.
  ///
  /// @param player - The player requesting to log the string to this game
  /// object.
  /// @param message - The string to log.
  /// @returns The arguments, as all input is valid.
  String? invalidateLog(String message) {
    if (message.length > maxLogLength) {
      return "Message is too long! Max $maxLogLength per message.";
    }
  }

  /// Logs a string to this BaseGameObject's log array, for debugging purposes.
  /// This is called from a 'run' event.
  ///
  /// @param player - The player requesting to log the string to this game
  /// object.
  /// @param message - The string to log.
  // eslint-disable-next-line @typescript-eslint/require-await
  void log(String message) {
    logs.add(message);
  }
}
