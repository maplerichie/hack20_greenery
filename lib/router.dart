import 'package:flutter/material.dart';
import 'screens/root.dart';
import 'screens/navi_404.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/trade_list.dart';
import 'screens/request_list.dart';
import 'screens/tour.dart';
import 'screens/topic.dart';
import 'screens/item.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  dynamic args = settings.arguments;
  print('Args: $args');
  print('Route: ${settings.name}');
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => Root());
    case '/home':
      return MaterialPageRoute(builder: (_) => HomeScreen());
    case '/login':
      return MaterialPageRoute(builder: (_) => LoginScreen());
    case '/tradelist':
      return MaterialPageRoute(builder: (_) => TradeListScreen());
    case '/requestlist':
      return MaterialPageRoute(builder: (_) => RequestListScreen());
    case '/tour':
      return MaterialPageRoute(builder: (_) => TourScreen());
    case '/topic':
      return MaterialPageRoute(builder: (_) => TopicScreen());
    case '/item':
      return MaterialPageRoute(builder: (_) => ItemScreen());
    default:
      return MaterialPageRoute(builder: (context) => Navi404());
  }
}
