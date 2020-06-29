import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'dart:math';
import '../models/rank.dart';
import '../models/user.dart';
import '../utils/datetime.dart';

class LeaderboardScreen extends StatefulWidget {
  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  List<Rank> _ranks = [];
  List<RankWeek> _rankWeeks = [];
  int _selectedWeek;
  User user;
  Random rnd = new Random();

  @override
  void initState() {
    super.initState();
    _initRanks();
  }

  Future<void> _initRanks() async {
    _rankWeeks = [
      RankWeek(
        id: 0,
        fromDay: DateTime(2020, 6, 27),
        toDay: DateTime(2020, 7, 3),
        weekNo: 1,
      ),
      RankWeek(
        id: 1,
        fromDay: DateTime(2020, 7, 4),
        toDay: DateTime(2020, 7, 10),
        weekNo: 2,
      ),
    ];
    _selectedWeek = _rankWeeks.length - 1;
    _ranks = [
      Rank(
        user: User(
          id: 1,
          firstName: 'John',
          lastName: 'Doe',
          avatar: 'assets/images/avatar1.png',
        ),
        currentWeekRank: 1,
        previousWeekRank: 2,
        weekPoints: 3612,
        totalPoints: 34121,
      ),
      Rank(
        user: User(
          id: 2,
          firstName: 'Melissa',
          lastName: 'Lin',
          avatar: 'assets/images/avatar2.png',
        ),
        currentWeekRank: 1,
        previousWeekRank: 2,
        weekPoints: 2363,
        totalPoints: 12356,
      ),
      Rank(
        user: User(
          id: 3,
          firstName: 'Jack',
          lastName: 'Dorsey',
          avatar: 'assets/images/avatar1.png',
        ),
        currentWeekRank: 1,
        previousWeekRank: 2,
        weekPoints: 1233,
        totalPoints: 61354,
      ),
      Rank(
        user: User(
          id: 4,
          firstName: 'Alice',
          lastName: 'Jean',
          avatar: 'assets/images/avatar2.png',
        ),
        currentWeekRank: 3,
        previousWeekRank: 2,
        weekPoints: 724,
        totalPoints: 125136,
      ),
      Rank(
        user: User(
          id: 5,
          firstName: 'Bill',
          lastName: 'Gates',
          avatar: 'assets/images/avatar1.png',
        ),
        currentWeekRank: 1,
        previousWeekRank: 1,
        weekPoints: 612,
        totalPoints: 13617,
      ),
    ];
    user = User(id: rnd.nextInt(_ranks.length - 1) + 1);
  }

  Widget _rankingState(int newRank, int previousRank) {
    if (newRank == previousRank) {
      return Icon(Mdi.minus, color: Colors.amber, size: 32.0);
    } else if (newRank < previousRank) {
      return Icon(Mdi.menuUp, color: Colors.green, size: 32.0);
    } else {
      return Icon(Mdi.menuDown, color: Colors.red, size: 32.0);
    }
  }

  Widget _champion(Rank rank) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 160,
        margin: EdgeInsets.only(bottom: 4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Mdi.trophy, color: Colors.amber, size: 32.0),
            CircleAvatar(
              radius: 60,
              child: Image.asset(rank.user.avatar),
              backgroundColor: Colors.transparent,
            ),
            Text(
              '${user.id == rank.user.id ? 'Me' : (rank.user.firstName + ' ' + rank.user.lastName)}',
              style: Theme.of(context).textTheme.headline6.copyWith(
                    color: user.id == rank.user.id ? Colors.amber : null,
                  ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _rankingState(rank.currentWeekRank, rank.previousWeekRank),
                  Container(
                    width: 1,
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    height: 16.0,
                    color: Colors.grey,
                  ),
                  Text(
                    '+${rank.weekPoints} ',
                    style: TextStyle(color: Colors.green),
                  ),
                  Icon(Mdi.currencyUsdCircle, color: Colors.green),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _rankCard(Rank rank, int index) {
    if (index == 0) {
      return _champion(rank);
    }
    return Card(
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            _rankingState(rank.currentWeekRank, rank.previousWeekRank),
            Container(
              padding: EdgeInsets.only(right: 8.0),
              child: Text(
                '${index + 1}',
                style: Theme.of(context).textTheme.headline6.copyWith(
                      color: user.id == rank.user.id ? Colors.amber : null,
                    ),
              ),
            ),
            CircleAvatar(
              child: Image.asset(rank.user.avatar),
              backgroundColor: Colors.transparent,
            ),
            Container(
              padding: EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${user.id == rank.user.id ? 'Me' : (rank.user.firstName + ' ' + rank.user.lastName)}',
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          color: user.id == rank.user.id ? Colors.amber : null,
                        ),
                  ),
                  Text(
                    'Total Points: ${rank.totalPoints}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    ' +${rank.weekPoints} ',
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.green),
                  ),
                  Icon(Mdi.currencyUsdCircle, color: Colors.green),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _changeWeek() async {
    await showDialog(
      context: context,
      child: StatefulBuilder(
        builder: (ctx, setState) => Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16),
                color: Colors.green,
                child: Text(
                  'Select a week',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.white),
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                itemCount: _rankWeeks.length,
                separatorBuilder: (ctx, index) => Divider(height: 1),
                itemBuilder: (ctx, index) => ListTile(
                  title: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Week #${_rankWeeks[index].weekNo}',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              '\t\t${formatDate(_rankWeeks[index].fromDay, "yMd")} - ${formatDate(_rankWeeks[index].toDay, "yMd")}',
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    _selectedWeek = index;

                    user = User(id: rnd.nextInt(_ranks.length - 1) + 1);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
    setState(() {});
  }

  Widget _weekCard() {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green, width: 4.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: EdgeInsets.all(8.0),
        alignment: Alignment.center,
        height: 70,
        width: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Week',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Colors.green),
            ),
            Text(
              '#${_rankWeeks[_selectedWeek].weekNo}',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.green),
            ),
          ],
        ),
      ),
      onTap: _changeWeek,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: _ranks.length,
            itemBuilder: (context, index) {
              return _rankCard(_ranks[index], index);
            },
          ),
          _weekCard(),
        ],
      ),
    );
  }
}
