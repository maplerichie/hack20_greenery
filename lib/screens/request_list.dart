import 'package:flutter/material.dart';
import '../models/request_item.dart';
import '../models/address.dart';
import '../utils/string.dart';
import '../widgets/dialog.dart';

class RequestListScreen extends StatefulWidget {
  @override
  _RequestListScreenState createState() => _RequestListScreenState();
}

class _RequestListScreenState extends State<RequestListScreen> {
  List<RequestItem> _requestItems = [];
  List<RequestItem> _filteredItem = [];
  List<RequestItem> _myItems = [];
  double _distanceFilter = 15;

  @override
  void initState() {
    super.initState();
    _initRequestItems();
    _initMyItems();
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
        id: 4,
        name: 'Bubble Wrap Roll',
        address: Address(
          city: 'Mersing',
          state: 'Johor',
        ),
        imageUrl: 'assets/images/item2.jpg',
      ),
      RequestItem(
        id: 5,
        name: 'Paper Box',
        address: Address(
          city: 'Kuantan',
          state: 'Pahang',
        ),
        imageUrl: 'assets/images/item1.jpg',
      ),
    ];
    _filteredItem = _requestItems;
  }

  Future<void> _initMyItems() async {}

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
                child: Image.asset('assets/images/logo.png'),
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
                    child: Image.asset(_filteredItem[index].imageUrl),
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

  Widget _listFilter() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(),
        ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('#Request'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        shrinkWrap: true,
        children: <Widget>[
          Text(
            'My Requests',
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
              '+ Create Request',
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
