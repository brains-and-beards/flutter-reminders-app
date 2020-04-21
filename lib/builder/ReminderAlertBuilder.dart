import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ReminderAlertBuilder extends StatefulWidget {
  ReminderAlertBuilder({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ReminderAlertBuilderState createState() => _ReminderAlertBuilderState();
}

class _ReminderAlertBuilderState extends State<ReminderAlertBuilder> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text('Add reminder'),
            onPressed: _showMaterialDialog,
          ),
        ],
      ),
    );
  }

  _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Create a reminder"),
              content: new Text("Choose action"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Add'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }
}
