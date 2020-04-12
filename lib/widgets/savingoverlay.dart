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

import 'dart:math';

import 'package:flutter/material.dart';

import '../messages.dart';

///
/// Shows an overlay over the main class when it is saving with some useful
/// information, does it as a semi-transparent overlay.
///
class SavingOverlay extends StatelessWidget {
  SavingOverlay({@required bool saving, @required this.child, int quoteId})
      : _saving = saving ?? false,
        _quoteId = quoteId ?? _randomNum.nextInt(20000);

  final bool _saving;
  final Widget child;
  final int _quoteId;

  static Random _randomNum = Random.secure();

  @override
  Widget build(BuildContext context) {
    QuoteAndAuthor quote = Messages.of(context).quoteforsaving(_quoteId);
    return new Stack(
      children: <Widget>[
        child,
        new AnimatedOpacity(
          opacity: _saving ? 0.8 : 0.0,
          duration: new Duration(seconds: 1),
          child: new Container(
            color: Colors.white,
            // Fill the whole page, drop it back when not saving to not
            // trap the gestures.
            constraints: _saving
                ? new BoxConstraints.expand()
                : new BoxConstraints.tight(const Size(0.0, 0.0)),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new RichText(
                  text: new TextSpan(
                    text: quote.quote,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
                new SizedBox(height: 10.0),
                new Text(quote.author,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(fontStyle: FontStyle.italic)),
                new SizedBox(height: 20.0),
                new CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
