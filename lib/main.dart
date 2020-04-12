import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_word_guesser/blocs/authenticationbloc.dart';
import 'package:flutter_word_guesser/screens/gameview.dart';
import 'package:flutter_word_guesser/screens/home.dart';
import 'package:flutter_word_guesser/services/gamedata.dart';

import 'messages.dart';

FirebaseAnalytics analytics = FirebaseAnalytics();

void main() {
  // Send error logs up to crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    analytics.logAppOpen();
    return RepositoryProvider<GameData>(
      create: (BuildContext context) => new GameData(),
      child: MultiBlocProvider(
        providers: <BlocProvider>[
          BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) =>
                AuthenticationBloc(analyticsSubsystem: analytics),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          initialRoute: '/',
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            MessagesDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: const <Locale>[
            const Locale('en', 'US'),
            const Locale('en', 'UK'),
            const Locale('en', 'AU'),
          ],
          onGenerateRoute: _generateRoute,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
        ),
      ),
    );
  }

  Route<dynamic> _generateRoute(RouteSettings settings) {
    var bits = settings.name.split("/");
    bits.removeWhere((element) => element.isEmpty);
    print("In here");
    if (bits.length == 0) {
      return MaterialPageRoute(
          settings: settings, builder: (context) => HomeScreen());
    }
    print("Fluff $bits");
    switch (bits[0]) {
      case "Game":
        if (bits.length > 1) {
          return MaterialPageRoute(
              settings: settings,
              builder: (context) => GameViewScreen(gameUid: bits[1]));
        }
    }
    return null;
  }
}
