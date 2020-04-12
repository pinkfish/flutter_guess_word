import 'dart:async';

import 'package:flutter/material.dart';

class CountdownWidget extends StatefulWidget {
  final DateTime endTime;
  final TextStyle style;

  CountdownWidget({this.endTime, this.style});

  @override
  State<CountdownWidget> createState() {
    return _CountdownWidgetState();
  }
}

class _CountdownWidgetState extends State<CountdownWidget> {
  Duration _duration;
  Timer _timer;

  @override
  void initState() {
    super.initState();

    _duration = widget.endTime.difference(DateTime.now());
    if (_duration.isNegative) {
      _duration = Duration(milliseconds: 0);
    }

    _timer = Timer.periodic(
        Duration(seconds: 1),
        (Timer t) => setState(() {
              _duration = widget.endTime.difference(DateTime.now());
              if (_duration.isNegative) {
                _duration = Duration(milliseconds: 0);
                _timer.cancel();
              }
            }));
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Text(_duration.inSeconds.toString(), style: widget.style);
  }
}
