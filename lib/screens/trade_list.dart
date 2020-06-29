import 'package:flutter/material.dart';
import '../models/trade_item.dart';
import '../models/address.dart';
import '../utils/string.dart';
import '../widgets/dialog.dart';

class TradeListScreen extends StatefulWidget {
  @override
  _TradeListScreenState createState() => _TradeListScreenState();
}

class _TradeListScreenState extends State<TradeListScreen> {
  List<TradeItem> _tradeItems = [];
  List<TradeItem> _filteredItem = [];
  List<TradeItem> _myItems = [];
  int _tradeTypeFilter = 0;
  double _distanceFilter = 15;

  @override
  void initState() {
    super.initState();
    _initTradeItems();
    _initMyItems();
  }

  Future<void> _initTradeItems() async {
    _tradeItems = [
      TradeItem(
        id: 0,
        name: 'Cotton Recycle bag',
        address: Address(
          city: 'Penang',
          state: 'Pinang',
        ),
        imageUrl: 'assets/images/item6.jpg',
      ),
      TradeItem(
        id: 1,
        name: 'Used flyer bag',
        address: Address(
          city: 'Cheras',
          state: 'Kuala Lumpur',
        ),
        imageUrl: 'assets/images/item5.jpg',
      ),
      TradeItem(
        id: 3,
        name: 'Dark Rubbish Bag',
        address: Address(
          city: 'Mersing',
          state: 'Johor',
        ),
        imageUrl: 'assets/images/item3.jpg',
      ),
      TradeItem(
        id: 4,
        name: 'Bubble Wrap Roll',
        address: Address(
          city: 'Mersing',
          state: 'Johor',
        ),
        imageUrl: 'assets/images/item2.jpg',
      ),
      TradeItem(
        id: 5,
        name: 'Paper Box',
        address: Address(
          city: 'Kuantan',
          state: 'Pahang',
        ),
        imageUrl: 'assets/images/item1.jpg',
      ),
    ];
    _filteredItem = _tradeItems;
  }

  Future<void> _initMyItems() async {
    _myItems = [
      TradeItem(
        imageUrl: 'assets/images/item4.jpg',
      ),
    ];
  }

  Widget _myItemGrid() {
    return GridView.builder(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemCount: _myItems.length,
      itemBuilder: (context, index) {
        return GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/item');
            },
            child: Material(
              elevation: 2.0,
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.grey[100],
              child: Container(
                height: ((MediaQuery.of(context).size.width - 16) / 3) - 8,
                child: Image.asset(_myItems[index].imageUrl),
              ),
            ),
          ),
        );
      },
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
      itemCount: _filteredItem.length,
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
                    child: Image.asset(_tradeItems[index].imageUrl),
                  ),
                ),
                Container(height: 1),
                Text(
                  capitalize(_filteredItem[index].name),
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

  void _filterTradeList(int type) {
    if (type != 0) {
      _filteredItem = [];
      _tradeItems.forEach((item) {
        if (item.tradeType == type) {
          _filteredItem.add(item);
        }
      });
    } else {
      _filteredItem = _tradeItems;
    }
    setState(() {});
  }

  Widget _listFilter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: Container(
            width: 120,
            child: DropdownButtonFormField(
              value: _tradeTypeFilter,
              items: [
                DropdownMenuItem(
                  value: 0,
                  child: Text('All'),
                ),
                ...TRADE_TYPE.asMap().entries.map((val) {
                  return DropdownMenuItem<int>(
                    value: val.key + 1,
                    child: Text(val.value),
                  );
                }).toList(),
              ],
              onChanged: (val) {
                _filterTradeList(val);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8.0, vertical: 13.0),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Slider(
                    label: 'Distance',
                    min: 5,
                    max: 30,
                    value: _distanceFilter,
                    onChanged: (value) {
                      setState(() {
                        _distanceFilter = value;
                      });
                    },
                  ),
                ),
                Text('${_distanceFilter.toStringAsFixed(0)} km'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trade Zone'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        shrinkWrap: true,
        children: <Widget>[
          Text(
            'My Items',
            style: Theme.of(context).textTheme.headline5,
          ),
          _myItems.length > 0
              ? _myItemGrid()
              : Container(
                  padding: EdgeInsets.only(left: 8.0, top: 4.0, bottom: 4.0),
                  child: Text('No listing yet'),
                ),
          RaisedButton(
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
            child: Text(
              '+ Create New Listing',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Divider(),
          _listFilter(),
          _tradeGrid(),
        ],
      ),
    );
  }
}
