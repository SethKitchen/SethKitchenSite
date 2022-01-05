import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sethkitchen/Pages/base_page.dart';

class HomePage extends BasePage {
  const HomePage({required key, required String name, required String path})
      : super(key: key, name: name, path: path);

  @override
  State<StatefulWidget> createState() => HomePageDefaultState();
}

class HomePageDefaultState extends State<HomePage> {
  Widget getTextForScreenSize(double width) {
    if (width > 800) {
      return Text(
        '"Check out my new KitchenCoin crypto-token I made on the Solana Blockchain!"',
        style: Theme.of(context)
            .textTheme
            .subtitle1!
            .copyWith(color: Colors.white),
      );
    } else {
      return SizedBox(
        width: 3 * width / 5,
        child: Text(
          '"Check out my new KitchenCoin crypto-token I made on the Solana Blockchain!"',
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: Colors.white),
        ),
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
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          color: Theme.of(context).secondaryHeaderColor,
                          height: 100,
                          width: width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, top: 5, bottom: 5),
                                  child: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "https://sethkitchen.github.io/images/avatar.jpg"),
                                      ))),
                              Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: getTextForScreenSize(width))
                            ],
                          ),
                        ),
                        Container(
                            color: Theme.of(context).backgroundColor,
                            height: height - 160,
                            width: width),
                      ])));
        }));
  }
}
