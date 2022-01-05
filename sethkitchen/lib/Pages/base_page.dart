import 'package:flutter/material.dart';

abstract class BasePage extends StatefulWidget {
  final String name;
  final String path;

  const BasePage({required Key key, required this.name, required this.path})
      : super(key: key);
}