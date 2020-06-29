import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:mdi/mdi.dart';
import 'package:provider/provider.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'dart:math';
import '../models/user.dart';
import '../models/rank.dart';
import '../services/http.dart';
import '../widgets/dialog.dart';
import '../widgets/snackbar_toast.dart';
import '../providers/auth.dart';

class MoreScreen extends StatefulWidget {
  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  Rank _rank;
  Random rnd = new Random();
  int currentRank;

  @override
  void initState() {
    super.initState();
    _initUser();
  }

  Future<void> _initUser() async {
    _rank = Rank(
      user: User(
        firstName: 'John',
        lastName: 'Doe',
        avatar: 'assets/images/avatar1.png',
      ),
      currentWeekRank: 1,
      previousWeekRank: 2,
      weekPoints: 3612,
      totalPoints: 34121,
    );
  }

  Widget _listTile(IconData icon, String text, VoidCallback callback) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(text),
        onTap: callback,
      ),
    );
  }

  Widget _pointTile() {
    return Card(
      child: ListTile(
        leading: Icon(Mdi.currencyUsdCircle, color: Colors.green),
        title: Text('Points balance: ${_rank.weekPoints}'),
        subtitle: Text('Total points: ${_rank.totalPoints}'),
        onTap: () {},
      ),
    );
  }

  Widget _about() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: '\nCrafted by ',
        style: Theme.of(context).textTheme.caption,
        children: <TextSpan>[
          TextSpan(
            text: 'Novelty Lab\n',
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                openUrl('https://noveltylab.io');
              },
          ),
        ],
      ),
    );
  }

  Widget _donation(String text, String address) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: text,
        style: Theme.of(context).textTheme.caption,
        children: <TextSpan>[
          TextSpan(
            text: address,
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
        ],
      ),
    );
  }

  Widget _avatarSection() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
      decoration: BoxDecoration(
        image: new DecorationImage(
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.75), BlendMode.dstATop),
          image: new AssetImage('assets/images/background.png'),
        ),
      ),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              currentRank == 1
                  ? Positioned(
                      top: 0,
                      right: 100,
                      child: Icon(Mdi.trophy, color: Colors.amber, size: 32.0),
                    )
                  : Container(),
              Center(
                child: CircleAvatar(
                  radius: 64,
                  child: Image.asset(_rank.user.avatar),
                  backgroundColor: Colors.transparent,
                ),
              ),
              Positioned(
                bottom: 10,
                right: 100,
                child: GestureDetector(
                  child:
                      Icon(Mdi.pencilCircle, color: Colors.green, size: 32.0),
                  onTap: () {},
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.green,
            ),
            child: Text(
              '${_rank.user.firstName + ' ' + _rank.user.lastName}',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    currentRank = rnd.nextInt(10 - 1) + 1;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _avatarSection(),
          _pointTile(),
          _listTile(
            Mdi.flag,
            'Tour',
            () {
              Navigator.of(context).pushNamed('/tour');
            },
          ),
          _listTile(
            Mdi.helpBox,
            'How to use',
            () async {
              await asyncAlert(
                  context, Text('Ops...'), Text('Feature not ready yet'), [
                FlatButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ]);
            },
          ),
          _listTile(
            Mdi.recycle,
            'Reduce, Reuse, Recycle Guide',
            () async {
              await asyncAlert(
                  context, Text('Ops...'), Text('Feature not ready yet'), [
                FlatButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ]);
            },
          ),
          _listTile(
            Mdi.handHeart,
            'Sponsor us!',
            () async {
              await asyncSimple(
                context,
                null,
                <Widget>[
                  Container(
                    padding: EdgeInsets.all(16),
                    color: Colors.green,
                    child: Text(
                      'Thank you',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  Text(
                    'BTC',
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await Clipboard.setData(new ClipboardData(
                          text: "1BHGQNzd23wopbdALtJmJNuexNcCiWcG9d"));
                      await displayToast('Copied BTC Address');
                    },
                    child: BarcodeWidget(
                      barcode: Barcode.qrCode(),
                      padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                      data: '1BHGQNzd23wopbdALtJmJNuexNcCiWcG9d',
                    ),
                  ),
                  Divider(),
                  Text(
                    'ETH',
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await Clipboard.setData(
                        new ClipboardData(
                            text: "0x492A18669580b2B4AF24B0e487af685cFA93E4Ea"),
                      );
                      await displayToast('Copied ETH Address');
                    },
                    child: BarcodeWidget(
                      barcode: Barcode.qrCode(),
                      padding: EdgeInsets.only(top: 4.0),
                      data: '0x492A18669580b2B4AF24B0e487af685cFA93E4Ea',
                    ),
                  ),
                  Container(
                    child: Text(
                      'Tap QR to copy address',
                      style: Theme.of(context).textTheme.caption,
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                ],
              );
            },
          ),
          _listTile(
            Mdi.logout,
            'Log out',
            () {
              Provider.of<AuthProvider>(context, listen: false).logout();
              Phoenix.rebirth(context);
            },
          ),
          _about(),
        ],
      ),
    );
  }
}
