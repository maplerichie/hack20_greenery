import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import '../models/address.dart';
import '../models/trade_item.dart';
import '../models/request_item.dart';
import '../utils/string.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isHideCard = false;
  List<TradeItem> _tradeItems = [];
  List<RequestItem> _requestItems = [];

  @override
  void initState() {
    super.initState();
    _initTradeItems();
    _initRequestItems();
  }

  Future<void> _initTradeItems() async {
    _tradeItems = [
      TradeItem(
        id: 0,
        name: 'Bubble wrap',
        address: Address(
          city: 'Serdang',
          state: 'Selangor',
        ),
        imageUrl: 'assets/images/item2.jpg',
      ),
      TradeItem(
        id: 1,
        name: 'Black plastic bag',
        address: Address(
          city: 'Kepong',
          state: 'Kuala Lumpur',
        ),
        imageUrl: 'assets/images/item3.jpg',
      ),
      TradeItem(
        id: 2,
        name: 'Large carton box',
        address: Address(
          city: 'Shah Alam',
          state: 'Selangor',
        ),
        imageUrl: 'assets/images/item1.jpg',
      ),
      TradeItem(
        id: 3,
        name: 'Plastic Food Container',
        address: Address(
          city: 'Mersing',
          state: 'Johor',
        ),
        imageUrl: 'assets/images/item4.jpg',
      ),
    ];
  }

  Future<void> _initRequestItems() async {
    _requestItems = [
      RequestItem(
        id: 0,
        name: 'Cotton Recycle bag',
        address: Address(
          city: 'Penang',
          state: 'Pinang',
        ),
        imageUrl: 'assets/images/item6.jpg',
      ),
      RequestItem(
        id: 1,
        name: 'Used flyer bag',
        address: Address(
          city: 'Cheras',
          state: 'Kuala Lumpur',
        ),
        imageUrl: 'assets/images/item5.jpg',
      ),
      RequestItem(
        id: 2,
        name: 'Washed Plastic Food Container',
        address: Address(
          city: 'Shah Alam',
          state: 'Selangor',
        ),
        imageUrl: 'assets/images/item4.jpg',
      ),
      RequestItem(
        id: 3,
        name: 'Dark Rubbish Bag',
        address: Address(
          city: 'Mersing',
          state: 'Johor',
        ),
        imageUrl: 'assets/images/item3.jpg',
      ),
      RequestItem(
        id: 3,
        name: 'Bubble Wrap Roll',
        address: Address(
          city: 'Mersing',
          state: 'Johor',
        ),
        imageUrl: 'assets/images/item2.jpg',
      ),
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _dailyTip() {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Tip of the Day!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                IconButton(
                  icon: Icon(Mdi.close),
                  onPressed: () {
                    setState(() {
                      _isHideCard = true;
                    });
                  },
                ),
              ],
            ),
            Text(
                'Do you know, the bubble wrap come free with your online purchase can be reuse by others, like family or friends doing home-based ecommerce.'),
            Container(
              padding: EdgeInsets.only(top: 4.0),
              width: double.maxFinite,
              alignment: Alignment.centerRight,
              child: GestureDetector(
                child: Text(
                  'Learn more',
                  style: Theme.of(context).textTheme.button,
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title(String title, VoidCallback callback) {
    return Container(
      padding: EdgeInsets.only(left: 16.0, top: 8.0, right: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.headline6.copyWith(),
          ),
          GestureDetector(
            child: Text('View all'),
            onTap: callback,
          ),
        ],
      ),
    );
  }

  Widget _tradeGrid() {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.6,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemCount: _tradeItems.length,
      itemBuilder: (context, index) {
        return GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/item');
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey[100],
                  child: Container(
                    height: ((MediaQuery.of(context).size.width - 16) / 3) - 8,
                    child: Image.asset(
                      _tradeItems[index].imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 1,
                ),
                Text(
                  capitalize(_tradeItems[index].name),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  _tradeItems[index].address.area,
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _requestGrid() {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.6,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemCount: _requestItems.length,
      itemBuilder: (context, index) {
        return GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/item');
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey[100],
                  child: Container(
                    height: ((MediaQuery.of(context).size.width - 16) / 3) - 8,
                    child: Image.asset(
                      _requestItems[index].imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 1,
                ),
                Text(
                  capitalize(_requestItems[index].name),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  _requestItems[index].address.area,
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      children: <Widget>[
        _isHideCard ? Container() : _dailyTip(),
        _title(
          'Trade Zone',
          () {
            Navigator.of(context).pushNamed('/tradelist');
          },
        ),
        _tradeGrid(),
        _title(
          '#Request',
          () {
            Navigator.of(context).pushNamed('/requestlist');
          },
        ),
        _requestGrid(),
      ],
    );
  }
}
