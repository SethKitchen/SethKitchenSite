import 'dart:async';
import 'dart:js' as js;
import 'dart:math';

import 'package:flutter/material.dart';

import 'html_source.dart';
import 'html_view.dart';

// ignore: must_be_immutable
class AdobePdfViewer extends StatefulWidget {
  String pdfUrl;
  String pdfFileName;
  late int myRandom;

  AdobePdfViewer({Key? key, required this.pdfUrl, required this.pdfFileName})
      : super(key: key) {
    Random r = Random();
    myRandom = r.nextInt(99999);
  }

  @override
  State<StatefulWidget> createState() => AdobePdfDefaultState();
}

class AdobePdfDefaultState extends State<AdobePdfViewer> {
  Timer? timer;
  bool hasLoadedPdf = false;
  int retries = 0;

  Future<void> doJsLoad() async {
    if (!hasLoadedPdf && retries < 6) {
      try {
        js.context.callMethod('loadPdf',
            <dynamic>[widget.pdfUrl, widget.pdfFileName, widget.myRandom]);
        hasLoadedPdf = true;
      } catch (ex) {
        retries++;
        print(ex);
      }
    } else {
      timer!.cancel();
    }
  }

  @override
  void dispose() {
    try {
      timer?.cancel();
    } catch (ex) {
      print(ex);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    hasLoadedPdf = false;
    timer = Timer.periodic(
        const Duration(milliseconds: 1000), (Timer t) => doJsLoad());

    return Align(
            alignment: Alignment.center,
            child: HTMLComp(
                  key: const ObjectKey(-1),
                  // -1 makes sure index is not already taken
                  index: -1,
                  columns: 1,
                  //Random
                  rows: 1,
                  //Random
                  onTapped: null,
                  onSelectedItemChanged: null,
                  maxSize: 1,
                  isSelected: false,
                  src: HTMLSource(
                    htmlSource: "<div id='adobe-dc-view" +
                        widget.myRandom.toString() +
                        "'></div>",
                  ),
                ));
  }
}
