import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:simple_moment/simple_moment.dart';
import '../models/address.dart';
import '../models/user.dart';
import '../models/trade_item.dart';
import '../utils/color.dart';
import '../widgets/dialog.dart';

class ItemScreen extends StatefulWidget {
  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  TradeItem _tradeItem;
  var moment = Moment.now();

  @override
  void initState() {
    super.initState();
    _initTradeItem();
  }

  Future<void> _initTradeItem() async {
    _tradeItem = TradeItem(
      id: 0,
      name: 'Large carton box',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      address: Address(
        id: 0,
        city: 'Shah Alam',
        state: 'Selangor',
      ),
      tradeType: 3,
      postedDate: DateTime(2020, 6, 27, 12, 0, 0),
      imageUrl: 'assets/images/item1.jpg',
      owner: User(
        firstName: 'Bob',
        lastName: 'Marry',
      ),
    );
  }

  Widget _itemPopup(int postId) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(Mdi.currencyUsdCircle, color: Colors.green),
              Text('Tips'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(Mdi.alertOctagon, color: Colors.red),
              Text('Report'),
            ],
          ),
        ),
      ],
      onSelected: (value) async {
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
      icon: Icon(Mdi.dotsVertical),
      offset: Offset(0, 100),
    );
  }

  Widget _imageCard(String imgUrl) {
    return Card(
      child: Container(
        child: Image.asset(
          imgUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _ownerInfo() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            child: Text(_tradeItem.owner.firstName[0]),
            backgroundColor: getRandomColor(),
            foregroundColor: Colors.white,
          ),
          Container(
            width: 8.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${_tradeItem.owner.firstName} ${_tradeItem.owner.lastName}',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              Text(
                '${moment.from(_tradeItem.postedDate)}',
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
          Expanded(
            child: Text(
              '${_tradeItem.address.city}, ${_tradeItem.address.state}',
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemInfo() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_tradeItem.name, style: Theme.of(context).textTheme.headline6),
          Text(_tradeItem.description,
              style: Theme.of(context).textTheme.subtitle1),
          Divider(),
          _tradeItem.tradeType == 3
              ? Row(
                  children: <Widget>[
                    Icon(Mdi.humanHandsup, color: Colors.red[700], size: 32.0),
                    Text(
                      'Free Hug',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _actions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: RaisedButton(
            color: Colors.blue,
            child: Text(
              'Message',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
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
        ),
        Container(width: 16),
        Expanded(
          child: RaisedButton(
            child: Text(
              'Deal!',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
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
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          _itemPopup(_tradeItem.id),
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          _imageCard(_tradeItem.imageUrl),
          _ownerInfo(),
          _itemInfo(),
          _actions(),
        ],
      ),
    );
  }
}
