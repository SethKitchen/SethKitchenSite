import 'dart:html';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HTMLSource extends StatefulWidget {
  String? htmlSource;
  String? viewFactoryId;
  final String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  HTMLSource(
      {Key? key,
      required this.htmlSource,})
      : super(key: key) {
    viewFactoryId = getRandomString(10);
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(viewFactoryId!, (int viewId) {
      final wrapper = DivElement()
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.overflowY = "auto";
      wrapper.innerHtml = htmlSource;
      return wrapper;
    });
  }

  HTMLSource.import(
      {Key? key, required String importText}) : super(key: key) {
    List<String> settings = importText.split('ϟ');
    htmlSource = settings[0];
    viewFactoryId = settings[1];
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(viewFactoryId!, (int viewId) {
      final wrapper = DivElement()
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.overflowY = "auto";
      wrapper.innerHtml = htmlSource;
      return wrapper;
    });
  }

  String exportText() {
    return htmlSource! + 'ϟ' + viewFactoryId!;
  }

  _HTMLSourceState? state;

  @override
  _HTMLSourceState createState() => _HTMLSourceState();
}

class _HTMLSourceState extends State<HTMLSource> {
  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: widget.viewFactoryId!);
  }
}
