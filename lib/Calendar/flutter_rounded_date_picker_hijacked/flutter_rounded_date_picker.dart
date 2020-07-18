import 'package:final_project_ver_2/Calendar/flutter_rounded_date_picker_hijacked/rounded_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Reservation extends StatefulWidget {
  @override
  _ReservationState createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  DateTime dateTime;
  Duration duration;

  @override
  void initState() {
    dateTime = DateTime.now();
    duration = Duration(minutes: 10);
    super.initState();
  }

  Widget calendarThai() {
    return FloatingActionButton.extended(
      onPressed: () async {
        DateTime newDateTime = await showRoundedDatePicker(
          context: context,
          locale: Locale("th", "TH"),
          era: EraMode.BUDDHIST_YEAR,
          initialDate: DateTime.now(),
          firstDate: DateTime(DateTime.now().year - 1),
          lastDate: DateTime(DateTime.now().year + 1),
          borderRadius: 5,

        );
        if (newDateTime != null) {
          setState(() => dateTime = newDateTime);
        }
      },
      label: Text("Rounded Calendar (Thai)"),
    );
  }

  Widget calendarEng() {
    return FloatingActionButton.extended(
      onPressed: () async {
        DateTime newDateTime = await showRoundedDatePicker(
          context: context,
          locale: Locale('en', 'US'),
          initialDate: DateTime.now(),
          firstDate: DateTime(DateTime.now().year - 1),
          lastDate: DateTime(DateTime.now().year + 1),
          borderRadius: 5,
        );
        if (newDateTime != null) {
          setState(() => dateTime = newDateTime);
        }
      },
      label: const Text("Rounded Calendar (English)"),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildBody() {
      return calendarThai();
      /*return Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Date Time selected",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    "$dateTime",
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Duration Selected",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                  ),
                  Text(
                    "$duration",
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 50),
              children: <Widget>[
                const SizedBox(height: 16),
                /*FloatingActionButton.extended(
                  onPressed: () async {
                    DateTime newDateTime = await showRoundedDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(DateTime.now().year - 1),
                      lastDate: DateTime(DateTime.now().year + 1),
                      borderRadius: 2,
                    );
                    if (newDateTime != null) {
                      setState(() => dateTime = newDateTime);
                    }
                  },
                  label: const Text("Material Calendar (Original)"),
                ),*/
                const SizedBox(height: 24),
                const Text(
                  "Rounded",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 12),
                calendarEng(),
                const SizedBox(height: 12),
                calendarThai(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      );*/
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Rounded Date Picker'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: _buildBody(),
      ),
    );
  }
}
