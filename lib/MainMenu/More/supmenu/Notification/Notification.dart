import 'package:flutter/material.dart';

class Notify extends StatefulWidget {
  @override
  _NotifyState createState() => _NotifyState();
}

bool _notify = false;

class _NotifyState extends State<Notify> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 70.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SwitchListTile(
              title: Text("Notifications"),
              value: _notify,
              onChanged: (bool value) {
                setState(
                  () {
                    _notify = value;
                  },
                );
              },
              secondary: Icon(Icons.notifications_active),
            )
          ],
        ),
      ),
    );
  }
}
