import './api_routes_abstract.dart';

class ApiRoutesFoundation implements ApiRoutesAbstract {
  @override
  Map<String, String> get routes => {};

  String? getRoute(String routeName, [Map<String, String>? params]) {
    if (params != null) {
      var newUrl = routes[routeName];
      if (newUrl != null) {
        for (var k in params.keys) {
          if (params[k] != null) {
            newUrl = newUrl!.replaceFirst('{$k}', params[k]!);
          }
        }
      }
      return newUrl;
    }

    return routes[routeName];
  }
}
