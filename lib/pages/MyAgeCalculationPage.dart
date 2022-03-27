import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tp2/models/DateDuration.dart';
import 'package:tp2/utlis/DateUtil.dart';

class MyAgeCalculationPage extends StatefulWidget {
  const MyAgeCalculationPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyAgeCalculationPage> createState() => _MyAgeCalculationPageState();
}

class _MyAgeCalculationPageState extends State<MyAgeCalculationPage> {
  DateTime _dateTime = DateTime.now();
  int _ageYears = 0,
      _ageMonth = 0,
      _ageDays = 0,
      _ageHours = 0,
      _ageMinutes = 0,
      _ageSeconds = 0;
  bool isAgeVisible = false;
  Timer timer = Timer(const Duration(), () {});

  void _showDatePicker() async {
    DateTime? _newDate = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(DateTime.now().year - 130),
      lastDate: DateTime.now(),
    );
    if (_newDate != null) {
      setState(() {
        _dateTime = _newDate;
      });
    }
  }

  void _calculateAge() {
    setState(() {
      DateDuration dateDuration =
          DateUtil(DateTime.now()).calculateSeconds(_dateTime);

      _ageSeconds = dateDuration.seconds;
      _ageMinutes = dateDuration.minutes;
      _ageHours = dateDuration.hours;
      _ageDays = dateDuration.days;
      _ageMonth = dateDuration.month;
      _ageYears = dateDuration.years;
    });
    if (timer.isActive) {
      timer.cancel();
    }
    timer =
        Timer.periodic(const Duration(seconds: 1), (timer) => _calculateAge());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(
              flex: 8,
            ),
            const Center(child: Text("Page non modifié")),
            Spacer(),
            const Center(
              child: Text("Date de naissance : "),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: _showDatePicker,
                  child: Row(
                    children: [
                      const Icon(Icons.date_range),
                      Text(
                        '${_dateTime.day}/${_dateTime.month}/${_dateTime.year}',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Spacer(
              flex: 2,
            ),
            Center(
              child: ElevatedButton.icon(
                onPressed: _calculateAge,
                icon: const Icon(Icons.calculate),
                label: const Text("Calcul"),
              ),
            ),
            Spacer(
              flex: 2,
            ),
            Center(
              child: Text('Tu as $_ageYears ans,'),
            ),
            Spacer(),
            Center(
              child: Text(
                  '$_ageMonth mois, $_ageDays jours, $_ageHours heure(s) $_ageMinutes minute(s) et $_ageSeconds second(s)'),
            ),
            Spacer(
              flex: 8,
            ),
          ],
        ),
      ),
    );
  }
}
