import 'package:flutter/material.dart';
import 'package:sethkitchen/Extensions/routing_data.dart';
import 'package:sethkitchen/Pages/about_me_page.dart';
import 'package:sethkitchen/Pages/base_page.dart';
import 'package:sethkitchen/Pages/home_page.dart';

import 'Extensions/hex_color.dart';

class RoutedApp extends MaterialApp {
  factory RoutedApp(
      Map<String, BasePage Function(BuildContext)> dynamicRoutes) {
    Map<String, BasePage Function(BuildContext)> knownRoutes = {
      '/': (BuildContext context) => HomePage(
          key: GlobalObjectKey<HomePageDefaultState>(
              DateTime.now().millisecondsSinceEpoch),
          name: 'homePage',
          path: '/'),
      '/about': (BuildContext context) => AboutMePage(
          key: GlobalObjectKey<HomePageDefaultState>(
              DateTime.now().millisecondsSinceEpoch),
          name: 'aboutMePage',
          path: '/about')
    };
    knownRoutes.addAll(dynamicRoutes);
    return RoutedApp._(knownRoutes);
  }

  static Route unKnownRoute(RouteSettings settings) {
    RoutingData routingData = settings.name!.getRoutingData;
    switch (routingData.route) {
      case '/':
        return MaterialPageRoute<dynamic>(builder: (context) {
          return HomePage(
              key: GlobalObjectKey<HomePageDefaultState>(
                  DateTime.now().millisecondsSinceEpoch),
              name: 'homePage',
              path: '/');
        });
      case '/about':
        return MaterialPageRoute<dynamic>(builder: (context) {
          return HomePage(
              key: GlobalObjectKey<AboutMePageDefaultState>(
                  DateTime.now().millisecondsSinceEpoch),
              name: 'aboutMePage',
              path: '/about');
        });
      default:
        return MaterialPageRoute<dynamic>(builder: (context) {
          return HomePage(
              key: GlobalObjectKey<HomePageDefaultState>(
                  DateTime.now().millisecondsSinceEpoch),
              name: 'homePage',
              path: '/');
        });
    }
  }

  RoutedApp._(Map routes)
      : super(
            title: 'Seth Kitchen | My Projects and Ventures',
            onUnknownRoute: unKnownRoute,
            onGenerateRoute: unKnownRoute,
            routes: routes as Map<String, Widget Function(BuildContext)>,
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light().copyWith(
                primaryColor: HexColor.fromHex('#282828'),
                secondaryHeaderColor: HexColor.fromHex("#505050"),
                backgroundColor: Colors.grey.withOpacity(.4),
                colorScheme: ThemeData.light().colorScheme.copyWith(
                      primary: HexColor.fromHex('#282828'),
                      onPrimary: Colors.white,
                      secondary: HexColor.fromHex("#0d47a1"),
                      error: const Color(0xFFC5032B),
                    ),
            ));
}
