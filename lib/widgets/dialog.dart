import 'package:flutter/material.dart';
import '../config/app.dart';

Future<void> asyncAlert(BuildContext context, Widget title, Widget content,
    List<Widget> actions) async {
  return showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: title,
        content: content,
        shape: RoundedRectangleBorder(),
        actionsOverflowDirection: VerticalDirection.down,
        actions: actions,
      );
    },
  );
}

Future<void> asyncAbout(BuildContext context, String title, String version,
    Widget icon, List<Widget> content) async {
  return showAboutDialog(
    context: context,
    applicationName: title,
    applicationVersion: version,
    applicationLegalese: '©️ 2020 ' + appName,
    applicationIcon: icon,
    children: content,
  );
}

Future<void> asyncSimple(
    BuildContext context, Widget title, List<Widget> widgets) async {
  return showDialog<void>(
    context: context,
    builder: (context) {
      return SimpleDialog(
        title: title,
        contentPadding: EdgeInsets.zero,
        children: widgets,
      );
    },
  );
}
