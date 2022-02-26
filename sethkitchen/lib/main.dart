import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sethkitchen/app.dart';
import 'package:worker_manager/worker_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /*if (Platform.isWindows) {
    await DesktopWindow.setMinWindowSize(const Size(400, 400));
  }*/

  await Executor().warmUp();

  runApp(const ProviderScope(child: App()));
}
