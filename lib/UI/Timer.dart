import 'package:countdown_app/services/events.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class TimerWidget extends StatefulWidget {
  final String title;
  final int dTime;
  final int time;
  final int division;
  final Duration duration;

  TimerWidget({
    this.title,
    this.time,
    this.division,
    this.duration,
    this.dTime,
  });

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Timer _timer;
  dynamic start;

  void startTimer() {
    start = widget.time ?? widget.dTime;
    _timer = Timer.periodic(widget.duration, (Timer time) {
      setState(() {
        if (start < 1) {
          time.cancel();
        } else {
          start = start - 1;
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          '${widget.title}',
          style: TextStyle(
            fontFamily: 'fantasy',
            fontStyle: FontStyle.italic,
            fontSize: 18.0,
          ),
        ),
        Text(
          widget.dTime == null
              ? '${start % widget.division}'
              : '${(start % widget.division / 7).toInt()}',
          style: TextStyle(
            fontFamily: 'fantasy',
            fontStyle: FontStyle.italic,
            fontSize: 18.0,
          ),
        ),
      ],
    );
  }
}
