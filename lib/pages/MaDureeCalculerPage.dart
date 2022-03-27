import 'package:flutter/material.dart';

import '../models/DateDuration.dart';
import '../utlis/DateUtil.dart';

class MaDureeCalculerPage extends StatefulWidget {
  const MaDureeCalculerPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MaDureeCalculerPage> createState() => _MaDureeCalculerPageState();
}

class _MaDureeCalculerPageState extends State<MaDureeCalculerPage> {
  int _durationYears = 0, _durationMonth = 0, _durationDays = 0;

  DateTime _dateTime1 = DateTime.now().add(const Duration(days: -1));
  DateTime _dateTime2 = DateTime.now();

  //DatePicker numéro 1
  void _showDatePicker1() async {
    DateTime? _newDate = await showDatePicker(
      context: context,
      initialDate: _dateTime1,
      firstDate: DateTime(0000),
      lastDate: _dateTime2.add(const Duration(days: -1)),
    );
    if (_newDate != null) {
      setState(() {
        _dateTime1 = _newDate;
      });
    }
  }

  //DatePicker numéro 2
  void _showDatePicker2() async {
    DateTime? _newDate = await showDatePicker(
      context: context,
      initialDate: _dateTime2,
      firstDate: _dateTime1.add(const Duration(days: 1)),
      lastDate: DateTime.now(),
    );
    if (_newDate != null) {
      setState(() {
        _dateTime2 = _newDate;
      });
    }
  }

  void _calculateDuration() {
    setState(() {
      DateDuration dateDuration =
          DateUtil(_dateTime2).calculateDays(_dateTime1);
      _durationDays = dateDuration.days;
      _durationMonth = dateDuration.month;
      _durationYears = dateDuration.years;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 8,
            ),
            const Center(
              child: Text(
                "Date 1 : ",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: _showDatePicker1,
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today_sharp),
                      Text(
                        '${_dateTime1.day}/${_dateTime1.month}/${_dateTime1.year}',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Center(
              child: Text(
                "Date 2 : ",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: _showDatePicker2,
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today_sharp),
                      Text(
                        '${_dateTime2.day}/${_dateTime2.month}/${_dateTime2.year}',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(
              flex: 2,
            ),
            Center(
              child: ElevatedButton.icon(
                onPressed: _calculateDuration,
                icon: const Icon(Icons.calculate),
                label: const Text("Calcul"),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            const Center(
              child: Text('La différance entre les 2 dates est de : '),
            ),
            const Spacer(),
            Center(
              child: Text(
                  '$_durationYears an(s), $_durationMonth mois et $_durationDays jours'),
            ),
            const Spacer(
              flex: 8,
            ),
          ],
        ),
      ),
    );
  }
}
