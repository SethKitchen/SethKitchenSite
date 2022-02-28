import 'package:flutter/material.dart';
import 'package:sethkitchen/Extensions/routing_data.dart';
import 'package:sethkitchen/Pages/about_me_page.dart';
import 'package:sethkitchen/Pages/kitchen_tower_defense_page.dart';
import 'package:sethkitchen/Pages/seth_home_page.dart';
import 'package:sethkitchen/app.dart';
import 'package:sethkitchen/wallet/pages/account_selection.dart';
import 'package:sethkitchen/wallet/pages/create_wallet.dart';
import 'package:sethkitchen/wallet/pages/home.dart';
import 'package:sethkitchen/wallet/pages/import_wallet.dart';
import 'package:sethkitchen/wallet/pages/manage_accounts.dart';
import 'package:sethkitchen/wallet/pages/watch_address.dart';

import 'Extensions/hex_color.dart';

class RoutedApp extends MaterialApp {
  factory RoutedApp(Map<String, Widget Function(BuildContext)> dynamicRoutes) {
    Map<String, Widget Function(BuildContext)> knownRoutes = {
      '/': (BuildContext context) => SethHomePage(
          key: GlobalObjectKey<SethHomePageDefaultState>(
              DateTime.now().millisecondsSinceEpoch),
          name: 'homePage',
          path: '/'),
      '/about': (BuildContext context) => AboutMePage(
          key: GlobalObjectKey<AboutMePageDefaultState>(
              DateTime.now().millisecondsSinceEpoch * 2),
          name: 'aboutMePage',
          path: '/about'),
      '/tower-defense': (BuildContext context) => TowerDefensePage(
          key: GlobalObjectKey<TowerDefensePageDefaultState>(
              DateTime.now().millisecondsSinceEpoch * 9),
          name: 'towerDefensePage',
          path: '/tower-defense'),
      '/wallet': (BuildContext context) => LinkListenerWrapper(
          child: WalletHomePage(
              key: GlobalObjectKey<AboutMePageDefaultState>(
                  DateTime.now().millisecondsSinceEpoch * 3),
              name: 'walletHomePage',
              path: '/wallet')),
      '/wallet/account/select': (BuildContext context) => LinkListenerWrapper(
          child: AccountSelectionPage(
              key: GlobalObjectKey<AboutMePageDefaultState>(
                  DateTime.now().millisecondsSinceEpoch * 4),
              name: 'walletAccountSelection',
              path: '/wallet/account/select')),
      '/wallet/watch/address': (BuildContext context) => LinkListenerWrapper(
          child: WatchAddress(
              key: GlobalObjectKey<AboutMePageDefaultState>(
                  DateTime.now().millisecondsSinceEpoch * 5),
              name: 'walletWatchAddress',
              path: '/wallet/watch/address')),
      '/wallet/create': (BuildContext context) => LinkListenerWrapper(
          child: CreateWallet(
              key: GlobalObjectKey<AboutMePageDefaultState>(
                  DateTime.now().millisecondsSinceEpoch * 6),
              name: 'walletCreate',
              path: '/wallet/create')),
      '/wallet/import': (BuildContext context) => LinkListenerWrapper(
          child: ImportWallet(
              key: GlobalObjectKey<AboutMePageDefaultState>(
                  DateTime.now().millisecondsSinceEpoch * 7),
              name: 'walletImport',
              path: '/wallet/import')),
      '/wallet/manage/account': (BuildContext context) => LinkListenerWrapper(
          child: ManageAccountsPage(
              key: GlobalObjectKey<AboutMePageDefaultState>(
                  DateTime.now().millisecondsSinceEpoch * 8),
              name: 'walletManageAccount',
              path: '/wallet/manage/account')),
    };
    knownRoutes.addAll(dynamicRoutes);
    return RoutedApp._(knownRoutes);
  }

  static Route unKnownRoute(RouteSettings settings) {
    RoutingData routingData = settings.name!.getRoutingData;
    switch (routingData.route) {
      case '/':
        return MaterialPageRoute<dynamic>(builder: (context) {
          return SethHomePage(
              key: GlobalObjectKey<SethHomePageDefaultState>(
                  DateTime.now().millisecondsSinceEpoch),
              name: 'homePage',
              path: '/');
        });
      case '/about':
        return MaterialPageRoute<dynamic>(builder: (context) {
          return AboutMePage(
              key: GlobalObjectKey<AboutMePageDefaultState>(
                  DateTime.now().millisecondsSinceEpoch * 2),
              name: 'aboutMePage',
              path: '/about');
        });
      case '/tower-defense':
        return MaterialPageRoute<dynamic>(builder:(context) {
          return TowerDefensePage(
          key: GlobalObjectKey<TowerDefensePageDefaultState>(
              DateTime.now().millisecondsSinceEpoch * 9),
          name: 'towerDefensePage',
          path: '/tower-defense');
        });
      case '/wallet':
        return MaterialPageRoute<dynamic>(builder: (context) {
          return LinkListenerWrapper(
              child: WalletHomePage(
                  key: GlobalObjectKey<AboutMePageDefaultState>(
                      DateTime.now().millisecondsSinceEpoch * 3),
                  name: 'walletHomePage',
                  path: '/wallet'));
        });
      case '/wallet/account/select':
        return MaterialPageRoute<dynamic>(builder: (context) {
          return LinkListenerWrapper(
              child: AccountSelectionPage(
                  key: GlobalObjectKey<AboutMePageDefaultState>(
                      DateTime.now().millisecondsSinceEpoch * 4),
                  name: 'walletAccountSelection',
                  path: '/wallet/account/select'));
        });
      case '/wallet/watch/address':
        return MaterialPageRoute<dynamic>(builder: (context) {
          return LinkListenerWrapper(
              child: WatchAddress(
                  key: GlobalObjectKey<AboutMePageDefaultState>(
                      DateTime.now().millisecondsSinceEpoch * 5),
                  name: 'walletWatchAddress',
                  path: '/wallet/watch/address'));
        });
      case '/wallet/create':
        return MaterialPageRoute<dynamic>(builder: (context) {
          return LinkListenerWrapper(
              child: CreateWallet(
                  key: GlobalObjectKey<AboutMePageDefaultState>(
                      DateTime.now().millisecondsSinceEpoch * 6),
                  name: 'walletCreate',
                  path: '/wallet/create'));
        });
      case '/wallet/import':
        return MaterialPageRoute<dynamic>(builder: (context) {
          return LinkListenerWrapper(
              child: ImportWallet(
                  key: GlobalObjectKey<AboutMePageDefaultState>(
                      DateTime.now().millisecondsSinceEpoch * 7),
                  name: 'walletImport',
                  path: '/wallet/import'));
        });
      case '/wallet/manage/account':
        return MaterialPageRoute<dynamic>(builder: (context) {
          return LinkListenerWrapper(
              child: CreateWallet(
                  key: GlobalObjectKey<AboutMePageDefaultState>(
                      DateTime.now().millisecondsSinceEpoch * 8),
                  name: 'walletManageAccount',
                  path: '/wallet/manage/account'));
        });
      default:
        return MaterialPageRoute<dynamic>(builder: (context) {
          return SethHomePage(
              key: GlobalObjectKey<SethHomePageDefaultState>(
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
