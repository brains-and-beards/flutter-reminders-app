import 'package:flutter/material.dart';

import 'ReminderAlertBuilder.dart';

class ReminderCustomItem extends StatelessWidget {
  final bool checkBoxValue;
  final void Function(bool) onChanged;
  final String iconName;
  final void Function() showTimeDialog;
  ReminderCustomItem(
      {this.checkBoxValue, this.onChanged, this.iconName, this.showTimeDialog});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: new EdgeInsets.only(left: 0, right: 0, bottom: 10),
        child: CheckboxListTile(
            value: checkBoxValue,
            onChanged: onChanged,
            title: Row(children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    remindersIcons[iconName],
                    color: Colors.blue,
                    size: 30.0,
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                          padding: new EdgeInsets.only(left: 10),
                          child: Text(
                            iconName,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal),
                          )),
                      SizedBox(
                        child: Padding(
                            padding: new EdgeInsets.only(top: 10, bottom: 10),
                            child: RaisedButton(
                              color: Colors.blue,
                              child: Text(
                                'SET TIME',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                              onPressed: showTimeDialog,
                            )),
                        width: 90,
                        height: 40,
                      )
                    ],
                  )
                ],
              )
            ])));
  }
}
