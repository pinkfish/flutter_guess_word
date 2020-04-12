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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_word_guesser/blocs/authenticationbloc.dart';
import 'package:flutter_word_guesser/widgets/playernameuid.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

///
/// Drawer to show stuff.
///
class GuesserDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.bodyText2;
    final List<Widget> aboutBoxChildren = <Widget>[
      SizedBox(height: 24),
      RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
                style: textStyle,
                text: 'Word Guesser is allows people to guess words together.  '
                    'It is super fun.'),
            TextSpan(
                style: textStyle.copyWith(color: Theme.of(context).accentColor),
                text: 'https://flutter.dev'),
            TextSpan(style: textStyle, text: '.'),
          ],
        ),
      ),
    ];

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          BlocBuilder(
            bloc: BlocProvider.of<AuthenticationBloc>(context),
            builder: (BuildContext context, AuthenticationState state) {
              if (state is AuthenticationLoggedIn) {
                return UserAccountsDrawerHeader(
                  accountEmail:
                      Text(state.user.email ?? "frog@unknownfrog.com"),
                  accountName: PlayerNameUid(
                    playerUid: state.user.uid,
                  ),
                  currentAccountPicture:
                      Image.asset("assets/images/basketball.png"),
                );
              }
              return DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                ),
                child: Text("Word Guesser"),
              );
            },
          ),
          BlocBuilder(
            bloc: BlocProvider.of<AuthenticationBloc>(context),
            builder: (BuildContext context, AuthenticationState state) {
              if (state is AuthenticationLoggedIn && !state.user.isAnonymous) {
                return ListTile(
                  leading: Icon(MdiIcons.logout),
                  title: Text("Logout"),
                  onTap: () {
                    BlocProvider.of<AuthenticationBloc>(context)
                        .add(AuthenticationEventLogout());
                  },
                );
              }

              return ListTile(
                leading: Icon(MdiIcons.login),
                title: _signInButton(context),
                onTap: () {
                  Navigator.pushNamed(context, "/Login/Home");
                },
              );
            },
          ),
          AboutListTile(
            icon: Icon(Icons.info),
            applicationIcon: FlutterLogo(),
            applicationName: "Word Guesser",
            applicationVersion: 'April 2020',
            applicationLegalese: '© 2020 The Whelksoft Authors',
            aboutBoxChildren: aboutBoxChildren,
          ),
        ],
      ),
    );
  }

  Widget _signInButton(BuildContext context) {
    return RaisedButton(
      splashColor: Theme.of(context).splashColor,
      onPressed: () => BlocProvider.of<AuthenticationBloc>(context)
          .add(AuthenticationEventAsGoogleUser()),
      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      //  borderSide: BorderSide(color: Theme.of(context).buttonColor),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
                image: AssetImage("assets/images/google_logo.png"),
                height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: Theme.of(context).primaryTextTheme.button,
              ),
            )
          ],
        ),
      ),
      color: Theme.of(context).primaryColor,
    );
  }
}
