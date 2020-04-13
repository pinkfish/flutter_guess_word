/*
 * Copyright (c) 2020 pinkfish
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to
 * deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
 * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
 * OR OTHER DEALINGS IN THE SOFTWARE.
 */

import 'dart:async';

import 'package:flutter/material.dart';

class CountdownWidget extends StatefulWidget {
  final DateTime endTime;
  final TextStyle style;
  final TextStyle styleLower;

  CountdownWidget({this.endTime, this.style, this.styleLower});

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
    Widget inner;
    if (_duration.inSeconds < 10) {
      inner = Text(
        _duration.inSeconds.toString(),
        style: widget.styleLower,
        key: ValueKey(_duration.inMilliseconds),
      );
    } else {
      inner = Text(
        _duration.inSeconds.toString(),
        style: widget.style,
        key: ValueKey(_duration.inMilliseconds),
      );
    }
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      switchInCurve: Curves.easeInOut,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          child: child,
          opacity: animation,
        );
      },
      child: inner,
    );
  }
}
