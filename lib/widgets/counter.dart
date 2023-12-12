import 'dart:async';
import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget(
      {super.key, required this.eventDate, required this.timeUnit});

  final String eventDate;
  final String timeUnit;

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  DateTime _dateTime = DateTime.now();
  // ignore: unused_field
  Timer? _timer;
  String _counter = '';

  @override
  void initState() {
    super.initState();
    // _stream = getTimeNow();
    _updateTime();
  }

  String _calculateTimeBetween() {
    var difference = DateTime.parse(widget.eventDate).difference(_dateTime);
    // return difference;

    switch (widget.timeUnit) {
      case 'CounterUnits.summary':
        return '$difference';
      case 'CounterUnits.years':
        return '${difference * 0.000114155} years left';
      case 'CounterUnits.months':
        return '${difference * 0.00136986} months left';
      case 'CounterUnits.weeks':
        return '${difference * 0.0059523743802857142} weeks left';
      case 'CounterUnits.days':
        return '${difference.inDays} days left';
      case 'CounterUnits.hours':
        return '${difference.inHours} hours left';
      case 'CounterUnits.minutes':
        return '${difference.inMinutes} minutes left';
      default:
        return '';
    }
  }

  void _updateTime() {
    setState(() {
      _counter = _calculateTimeBetween();
      _dateTime = DateTime.now();
      // Update once per minute. If you want to update every second, use the
      // following code.
      _timer = Timer(
        Duration(minutes: 1) -
            Duration(seconds: _dateTime.second) -
            Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _counter,
      style: const TextStyle(fontSize: 36, overflow: TextOverflow.clip),
    );
  }
}
