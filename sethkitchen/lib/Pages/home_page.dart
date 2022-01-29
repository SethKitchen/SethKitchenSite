import 'dart:js' as js;

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sethkitchen/Extensions/video_player.dart';
import 'package:sethkitchen/Pages/base_page.dart';

class HomePage extends BasePage {
  const HomePage({required key, required String name, required String path})
      : super(key: key, name: name, path: path);

  @override
  State<StatefulWidget> createState() => HomePageDefaultState();
}

class HomePageDefaultState extends State<HomePage> {
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

  Widget getStaggeredGrid() {
    return StaggeredGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Card(
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Expanded(
                          child: Image.network(
                              "https://avatars.githubusercontent.com/u/9014645?s=400&u=87aa1c99ac7e25c5690ed9e8e97cadaecc1a4ca6&v=4")),
                      MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed('/about');
                              },
                              child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text("About Me"))))
                    ],
                  ))),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Card(
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Expanded(
                          child: Image.network(
                              "https://sethkitchen.github.io/images/kitchentokenwhite.png")),
                      const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text("Buy Kitchen Token"))
                    ],
                  ))),
        ),
        const StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 1,
            child: Card(
                child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("Coming Soon... Kitchen Tower Defense"))))),
        StaggeredGridTile.count(
            crossAxisCellCount: 4,
            mainAxisCellCount: 2,
            child: Card(
                child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                            child: Container(
                                color: Colors.grey,
                                child: const NonYoutubeVideo(
                                    link:
                                        "https://sethkitchen.github.io/images/intro.mp4"))),
                        Align(
                            alignment: Alignment.center,
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                        onTap: () {
                                          js.context.callMethod('open', [
                                            'https://www.youtube.com/watch?v=vtd0MVolUag&list=PLPcMzivP6_AO4smiXYnDaQS7psUNI5oJY'
                                          ]);
                                        },
                                        child: const Text(
                                            "Data Science course on Youtube")))))
                      ],
                    )))),
      ],
    );
  }

  Widget getGridForScreenSize(double width, double height) {
    if (width > 1000) {
      return SizedBox(width: 800, child: getStaggeredGrid());
    } else {
      return getStaggeredGrid();
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
                                        "https://sethkitchen.github.io/images/avatar.jpg"),
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
                      child: getGridForScreenSize(width, height),
                    ),
                  ])));
        }));
  }
}
