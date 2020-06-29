import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mdi/mdi.dart';
import '../screens/home.dart';
import '../screens/brainstorm.dart';
import '../screens/leaderboard.dart';
import '../screens/more.dart';
import '../providers/navi.dart';
import '../config/app.dart';

final List<Screen> allScreens = <Screen>[
  Screen(appName, Mdi.home, 'Home', Colors.green, HomeScreen(), true, true),
  Screen('Brainstorm', Mdi.brain, 'Space', Colors.red, BrainstormScreen(), true,
      true),
  Screen('Leaderboard', Mdi.trophy, 'Empty', Colors.yellow, LeaderboardScreen(),
      true, false),
  Screen('More', Mdi.dotsHorizontalCircle, 'More', Colors.blue, MoreScreen(),
      false, false),
];

class BottomNavi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var naviProvider = Provider.of<NaviProvider>(context);
    return BottomNavigationBar(
      currentIndex: naviProvider.currentIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Theme.of(context).primaryColor,
      onTap: (int index) {
        naviProvider.setActiveIndex(index, allScreens[index].showAppbar,
            allScreens[index].showActions, allScreens[index].appBarTitle);
      },
      items: allScreens.map((Screen screen) {
        return BottomNavigationBarItem(
          icon: Icon(
            screen.icon,
            color: Colors.grey.withOpacity(0.5),
          ),
          activeIcon: Icon(
            screen.icon,
            color: screen.color,
          ),
          title: Text(screen.title),
        );
      }).toList(),
    );
  }
}

class Screen {
  final String appBarTitle;
  final IconData icon;
  final String title;
  final Color color;
  final Widget screen;
  final bool showAppbar;
  final bool showActions;

  Screen(this.appBarTitle, this.icon, this.title, this.color, this.screen,
      this.showAppbar, this.showActions);

  Widget get getScreen {
    return screen;
  }
}
