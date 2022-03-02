import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sethkitchen/Pages/TowerDefense/game.dart';
import 'package:sethkitchen/Pages/base_page.dart';

class TowerDefensePage extends BasePage {
  TowerDefensePage({required key, required String name, required String path})
      : super(key: key, name: name, path: path);

  @override
  State<StatefulWidget> createState() => TowerDefensePageDefaultState();
}

class TowerDefensePageDefaultState extends State<TowerDefensePage> {
  String quoteText =
      '"Currently messing with Kitchen token on Solana blockchain!"';
  KitchenDefenseGame? game;

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
    game ??= KitchenDefenseGame(mapWidth: width, mapHeight: height - 160);
    return Container(
      color: Colors.lightBlue,
      child: Column(children: [Expanded(child: GameWidget(game: game!))]),
    );
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
