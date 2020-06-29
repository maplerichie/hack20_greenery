import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mdi/mdi.dart';
import '../providers/auth.dart';
import '../providers/navi.dart';
import '../widgets/bottom_navigation.dart';
import '../screens/login.dart';
import '../widgets/dialog.dart';

class Root extends StatelessWidget {
  List<Widget> _actionsBtn(int tabIndex, BuildContext context) {
    IconData icon;
    VoidCallback callback;
    switch (tabIndex) {
      case 0:
        icon = Mdi.message;
        callback = () async {
          await asyncAlert(
              context, Text('Ops...'), Text('Feature not ready yet'), [
            FlatButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ]);
        };
        break;
      case 1:
        icon = Mdi.pencil;
        callback = () async {
          await asyncAlert(
              context, Text('Ops...'), Text('Feature not ready yet'), [
            FlatButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ]);
        };

        break;
      case 2:
        break;
      default:
        break;
    }
    return <Widget>[
      IconButton(
        icon: Icon(icon),
        onPressed: callback,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, AuthProvider auth, _) {
      switch (auth.status) {
        case Status.Uninitialized:
          return SplashScreen();
        case Status.Authenticated:
          return Consumer(builder: (context, NaviProvider navi, _) {
            return Scaffold(
              appBar: navi.showAppbar
                  ? AppBar(
                      title: Text(navi.appBarTitle),
                      centerTitle: false,
                      actions: !navi.showActions
                          ? null
                          : _actionsBtn(navi.currentIndex, context),
                    )
                  : null,
              bottomNavigationBar: BottomNavi(),
              body: allScreens[navi.currentIndex].getScreen,
            );
          });
          break;
        default:
          return LoginScreen();
      }
    });
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff45B649), Color(0xffDCE35B)],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: SpinKitCircle(
        color: Colors.white,
        size: 50.0,
      ),
    );
  }
}
