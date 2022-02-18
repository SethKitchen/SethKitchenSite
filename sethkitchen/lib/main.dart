import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sethkitchen/router.dart';
import 'package:worker_manager/worker_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /*if (Platform.isWindows) {
    await DesktopWindow.setMinWindowSize(const Size(400, 400));
  }*/

  await Executor().warmUp();

  runApp(ProviderScope(child: RoutedApp(const {})));
}
