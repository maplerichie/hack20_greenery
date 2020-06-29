import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:simple_moment/simple_moment.dart';
import '../models/user.dart';
import '../models/topic.dart';
import '../utils/color.dart';
import '../widgets/dialog.dart';

class BrainstormScreen extends StatefulWidget {
  @override
  _BrainstormScreenState createState() => _BrainstormScreenState();
}

class _BrainstormScreenState extends State<BrainstormScreen> {
  List<Topic> _topics = [];
  var moment = Moment.now();

  @override
  void initState() {
    super.initState();
    _initTopics();
  }

  Future<void> _initTopics() async {
    _topics = [
      Topic(
        id: 0,
        author: User(
          firstName: 'John',
          lastName: 'Doe',
          avatar: 'assets/images/logo.png',
        ),
        title: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
        body:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
        datetime: DateTime(2020, 6, 27, 12, 0, 0),
        comments: [
          Comment(id: 0),
        ],
        points: 12,
      ),
      Topic(
        id: 1,
        author: User(
          firstName: 'Bob',
          lastName: 'Marry',
          avatar: 'assets/images/logo.png',
        ),
        title: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
        body:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
        datetime: DateTime(2020, 6, 26, 12, 0, 0),
      ),
    ];
  }

  Widget _topicPopup(int postId) {
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

  Widget _topicCard(Topic topic) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/topic');
      },
      child: Card(
        elevation: 4.0,
        margin: EdgeInsets.only(bottom: 4.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    child: Text(topic.author.firstName[0]),
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
                        '${topic.author.firstName} ${topic.author.lastName}',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      Text(
                        '${moment.from(topic.datetime)}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: _topicPopup(topic.id),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  topic.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Text(
                  topic.body,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(Mdi.currencyUsdCircle, color: Colors.green),
                      Text(
                        ' ${topic.points} ',
                        style: Theme.of(context).textTheme.caption.copyWith(
                            color:
                                topic.points >= 0 ? Colors.green : Colors.red),
                      ),
                    ],
                  ),
                  Text(
                    '${topic.comments.length} Comments',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: _topics.length,
        itemBuilder: (BuildContext ctx, int index) {
          return _topicCard(_topics[index]);
        });
  }
}
