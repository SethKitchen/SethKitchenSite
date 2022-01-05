import 'dart:core';

class RoutingData {
  final String route;
  final Map<String, String> queryParameters;

  RoutingData({
    required this.route,
    required Map<String, String> qParameters,
  }) : queryParameters = qParameters;

  String? operator [](String key) {
    return queryParameters[key];
  }
}

extension StringExtension on String {
  RoutingData get getRoutingData {
    var uriData = Uri.parse(this);
    return RoutingData(
      qParameters: uriData.queryParameters,
      route: uriData.path,
    );
  }
}