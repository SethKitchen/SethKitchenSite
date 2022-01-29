import 'dart:js' as js;

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sethkitchen/Extensions/AdobePdfViewer.dart';
import 'package:sethkitchen/Extensions/video_player.dart';
import 'package:sethkitchen/Pages/base_page.dart';

class AboutMePage extends BasePage {
  const AboutMePage({required key, required String name, required String path})
      : super(key: key, name: name, path: path);

  @override
  State<StatefulWidget> createState() => AboutMePageDefaultState();
}

class AboutMePageDefaultState extends State<AboutMePage> {
  String quoteText =
      '"Currently messing with Kitchen token on Solana blockchain!"';

  Widget getTextForScreenSize(double width) {
    if (width > 800) {
      return Text(
        quoteText,
        style: Theme.of(context)
            .textTheme
            .subtitle1!
            .copyWith(color: Colors.white),
      );
    } else {
      return SizedBox(
        width: 3 * width / 5,
        child: Text(
          quoteText,
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: Colors.white),
        ),
      );
    }
  }

  Widget getColumnForScreenSize(double width, double height) {
    if (width > 1000) {
      return Container(
        color: Colors.lightBlue,
        width: 800,
        child: Column(children: [
          const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                  "From Software to Space 🚀, I'm coming for Elon and Bezos! Check out my Resume below.")),
          Expanded(
              child: Container(
                  color: Colors.purple,
                  child: AdobePdfViewer(
                      pdfUrl: "https://seth.kitchen/images/Resume.pdf",
                      pdfFileName: "Resume")))
        ]),
      );
    } else {
      return Container(
        color: Colors.lightBlue,
        child: Column(children: [
          const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                  "From Software to Space 🚀, I'm coming for Elon and Bezos! Check out my Resume below.")),
          Expanded(
              child: Container(
                  color: Colors.purple,
                  child: AdobePdfViewer(
                      pdfUrl: "https://seth.kitchen/images/Resume.pdf",
                      pdfFileName: "Resume")))
        ]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text("Seth J. Kitchen",
              style: GoogleFonts.justAnotherHand().copyWith(fontSize: 35)),
        ),
        body: Builder(builder: (context) {
          return SingleChildScrollView(
              child: SizedBox(
                  height: height - 60,
                  child: Column(children: <Widget>[
                    Container(
                      color: Theme.of(context).secondaryHeaderColor,
                      height: 100,
                      width: width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                              padding:
                                  EdgeInsets.only(left: 10, top: 5, bottom: 5),
                              child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "https://seth.kitchen/images/avatar.jpg"),
                                  ))),
                          Padding(
                              padding: const EdgeInsets.all(10),
                              child: getTextForScreenSize(width)),
                        ],
                      ),
                    ),
                    Container(
                      color: Theme.of(context).backgroundColor,
                      height: height - 160,
                      child: getColumnForScreenSize(width, height),
                    ),
                  ])));
        }));
  }
}
