import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BasePage extends StatefulWidget {
  final String name;
  final String path;

  const BasePage({required Key key, required this.name, required this.path})
      : super(key: key);
}
