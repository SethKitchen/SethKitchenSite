import 'dart:html';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HTMLHiddenSource extends StatefulWidget {
  String? htmlSource;
  String? viewFactoryId;
  GlobalKey toolbarPageKeyForUpdateState;
  final String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  HTMLHiddenSource(
      {Key? key,
      required this.htmlSource,
      required this.toolbarPageKeyForUpdateState})
      : super(key: key) {
    viewFactoryId = getRandomString(10);
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(viewFactoryId!, (int viewId) {
      final wrapper = DivElement()
        ..style.width = '0'
        ..style.height = '0'
        ..style.display = 'none'
        ..style.visibility = 'hidden';
      wrapper.innerHtml = htmlSource;
      return wrapper;
    });
  }

  HTMLHiddenSource.import(
      {Key? key,
      required String importText,
      required this.toolbarPageKeyForUpdateState})
      : super(key: key) {
    List<String> settings = importText.split('ϟ');
    htmlSource = settings[0];
    viewFactoryId = settings[1];
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(viewFactoryId!, (int viewId) {
      final wrapper = DivElement()
        ..style.width = '0'
        ..style.height = '0'
        ..style.display = 'none'
        ..style.visibility = 'hidden';
      wrapper.innerHtml = htmlSource;
      return wrapper;
    });
  }

  String exportText() {
    return htmlSource! + 'ϟ' + viewFactoryId!;
  }

  @override
  _HTMLHiddenSourceState createState() => _HTMLHiddenSourceState();
}

class _HTMLHiddenSourceState extends State<HTMLHiddenSource> {
  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: widget.viewFactoryId!);
  }
}
