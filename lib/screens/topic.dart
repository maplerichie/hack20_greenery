import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:simple_moment/simple_moment.dart';
import '../models/user.dart';
import '../models/topic.dart';
import '../utils/color.dart';
import '../widgets/dialog.dart';

class TopicScreen extends StatefulWidget {
  @override
  _TopicScreenState createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  Topic _topic;
  var moment = Moment.now();
  TextEditingController _commentCtrl;

  @override
  void initState() {
    super.initState();
    _commentCtrl = new TextEditingController();
    _initTopics();
  }

  Future<void> _initTopics() async {
    _topic = Topic(
      id: 0,
      author: User(
        firstName: 'John',
        lastName: 'Doe',
      ),
      title: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
      body:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      datetime: DateTime(2020, 6, 27, 12, 0, 0),
      points: 12,
      comments: [
        Comment(
          id: 0,
          author: User(
            firstName: 'Bob',
            lastName: 'Marry',
            avatar: 'assets/images/logo.png',
          ),
          comment:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
          points: -1,
          datetime: DateTime(2020, 6, 27, 12, 0, 0),
        ),
      ],
    );
  }

  Widget _topicCard(Topic topic) {
    return Card(
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(Mdi.currencyUsdCircle, color: Colors.green),
                Text(
                  ' ${topic.points} ',
                  style: Theme.of(context).textTheme.caption.copyWith(
                      color: topic.points >= 0 ? Colors.green : Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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

  Widget _commendCard(Comment comment) {
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.all(4.0),
        leading: CircleAvatar(
          child: Text(comment.author.firstName[0]),
          backgroundColor: getRandomColor(),
          foregroundColor: Colors.white,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '${comment.author.firstName} ${comment.author.lastName}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Text(comment.comment),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(Mdi.currencyUsdCircle, color: Colors.green),
                Text(
                  ' ${comment.points} ',
                  style: Theme.of(context).textTheme.caption.copyWith(
                      color: comment.points >= 0 ? Colors.green : Colors.red),
                ),
              ],
            ),
          ],
        ),
        trailing: _topicPopup(comment.id),
      ),
    );
  }

  Widget _replyComment() {
    return Container(
      padding: EdgeInsets.all(4.0),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _commentCtrl,
              keyboardType: TextInputType.multiline,
              maxLines: 2,
              maxLength: 120,
              decoration: InputDecoration(
                hintText: 'Add a comment',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                fillColor: Colors.grey[200],
                filled: true,
                suffix: GestureDetector(
                  child: Icon(Mdi.send),
                  onTap: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          _topicPopup(_topic.id),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(8.0),
              children: <Widget>[
                _topicCard(_topic),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  child: Text('Comments'),
                ),
                ..._topic.comments
                    .map((comment) => _commendCard(comment))
                    .toList(),
              ],
            ),
          ),
          _replyComment(),
        ],
      ),
    );
  }
}
