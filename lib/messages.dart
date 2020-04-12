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
import 'package:flutter_word_guesser/blocs/authenticationbloc.dart';
import 'package:intl/intl.dart';

import 'l10n/messages_all.dart';

class Messages {
  static Future<Messages> load(Locale locale) async {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return new Messages(localeName);
    });
  }

  static Messages of(BuildContext context) {
    return Localizations.of<Messages>(context, Messages);
  }

  Messages(this.locale);

  final String locale;

  String get title => Intl.message("Basketball stats",
      desc: "Title of the app", locale: locale, args: []);

  String get loading => Intl.message("Loading...",
      desc: "Message to show while loading data", locale: locale, args: []);

  String get about => Intl.message("About",
      desc: "Menu item to open information about the app",
      locale: locale,
      args: []);

  String get settings => Intl.message("Settings",
      desc: "Menu item to open information settings of the app",
      locale: locale,
      args: []);

  String get emptyText => Intl.message("Must not be empty",
      desc: "Hint text to say the name must not be empty",
      locale: locale,
      args: []);

  String get errorForm => Intl.message("Error in the form",
      desc: "Snackbar that pops up to show that there is an error",
      locale: locale,
      args: []);

  String get saveFailed => Intl.message("Save Failed",
      desc: "Failed to save a photo", locale: locale, args: []);

  String get saveButton => Intl.message("SAVE",
      desc: "Text on a save button", locale: locale, args: []);

  String get gamesButton => Intl.message("GAMES",
      desc: "Text on a games button", locale: locale, args: []);

  String get editButton => Intl.message("EDIT",
      desc: "Text on a edit button", locale: locale, args: []);

  String get endButton => Intl.message("END",
      desc: "Text on a end button", locale: locale, args: []);

  String get startButton => Intl.message("START",
      desc: "Text on a button to start the period", locale: locale, args: []);

  String get unknown => Intl.message("unknown",
      desc: "Used when the data is unknown", locale: locale, args: []);

  String get players => Intl.message("Players",
      desc: "Used when the data is unknown", locale: locale, args: []);

  String get _badPasswordReason =>
      Intl.message('Email and/or password incorrect',
          desc: 'Passwords or email is not correct, login failed',
          locale: locale,
          args: []);

  String get _internalErrorPasswordReason => Intl.message('Internal Error',
      desc: 'Something happened inside the login system, not a bad password',
      locale: locale,
      args: []);

  String get _cancellerErrorReason => Intl.message('Login Cancelled',
      desc: 'Login was cancelled', locale: locale, args: []);

  String loginFailureReason(LoginFailedReason reason) {
    switch (reason) {
      case LoginFailedReason.BadPassword:
        return _badPasswordReason;
      case LoginFailedReason.InternalError:
        return _internalErrorPasswordReason;
      case LoginFailedReason.Cancelled:
        return _cancellerErrorReason;
    }
    return unknown;
  }

  String get displayname => Intl.message('Name',
      desc: 'Name for the edit box to edit the user name', args: []);

  String get _markTwainQuote =>
      Intl.message("Lies, Damn Lies and Statistics", locale: locale, args: []);

  String get _markTwainName =>
      Intl.message("Mark Twain", locale: locale, args: []);

  String get _michaelJoronQuote => Intl.message(
      "I've missed more than 9000 shots in my career. "
          "I've lost almost 300 games. 26 times, "
          "I've been trusted to take the game winning shot and missed. "
          "I've failed over and over and over again in my life. "
          "And that is why I succeed.",
      locale: locale,
      args: []);

  String get _michaelJordanName =>
      Intl.message("Michael Jordan", locale: locale, args: []);

  String get _geraldFordQuote => Intl.message(
      "I know I am getting better at golf because I am hitting fewer spectators.",
      locale: locale,
      args: []);

  String get _geraldFordName =>
      Intl.message("Gerald B Ford", locale: locale, args: []);

  String get _douglasAdamsQuote =>
      Intl.message("Don't Panic", locale: locale, args: []);

  String get _douglasAdminsName =>
      Intl.message("Douglas Adams", locale: locale, args: []);

  QuoteAndAuthor quoteforsaving(int quoteId) {
    switch (quoteId % 4) {
      case 0:
        return new QuoteAndAuthor(
          quote: _markTwainQuote,
          author: _markTwainName,
        );
      case 1:
        return new QuoteAndAuthor(
          quote: _michaelJoronQuote,
          author: _michaelJordanName,
        );
      case 2:
        return new QuoteAndAuthor(
          quote: _geraldFordQuote,
          author: _geraldFordName,
        );
      default:
        return new QuoteAndAuthor(
          quote: _douglasAdamsQuote,
          author: _douglasAdminsName,
        );
    }
  }
}

class QuoteAndAuthor {
  QuoteAndAuthor({this.quote, this.author});

  String quote;
  String author;
}

class MessagesDelegate extends LocalizationsDelegate<Messages> {
  const MessagesDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<Messages> load(Locale locale) => Messages.load(locale);

  @override
  bool shouldReload(MessagesDelegate old) => false;
}
