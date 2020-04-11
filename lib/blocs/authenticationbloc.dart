import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

///
/// States for the authentication bloc.
///
abstract class AuthenticationState extends Equatable {
  final FirebaseUser user;

  AuthenticationState({@required this.user});

  @override
  List<Object> get props => [user?.email];
}

class AuthenticationUninitialized extends AuthenticationState {
  AuthenticationUninitialized() : super(user: null);

  @override
  String toString() => "AuthenticationState::AuthenticatonUninitialized";
}

class AuthenticationValidating extends AuthenticationState {
  AuthenticationValidating() : super(user: null);

  @override
  String toString() => "AuthenticationState::AuthenticationValidating";
}

enum LoginFailedReason {
  BadPassword,
  InternalError,
  Cancelled,
}

class AuthenticationError extends AuthenticationState {
  AuthenticationError({@required this.reason}) : super(user: null);

  final LoginFailedReason reason;

  @override
  String toString() => "AuthenticationState::AuthenticationError";
}

///
/// The user is logged in.
///
class AuthenticationLoggedIn extends AuthenticationState {
  AuthenticationLoggedIn({@required FirebaseUser user}) : super(user: user);

  @override
  String toString() =>
      "AuthenticationState::AuthenticatonLoggedIn{${user.email}}";
}

///
/// The user is logged out.
///
class AuthenticationLoggedOut extends AuthenticationState {
  AuthenticationLoggedOut() : super(user: null);

  @override
  String toString() => "AuthenticationState::AuthenticatonUninitialized";
}

///
/// Events associated with the authentication bloc
///
abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent() : super();
}

class _AuthenticationLogIn extends AuthenticationEvent {
  final FirebaseUser user;

  _AuthenticationLogIn({@required this.user});

  @override
  String toString() => "LoggedIn";

  @override
  List<Object> get props => [user];
}

///
/// Logs the current user out.
///
class _AuthenticationLogOut extends AuthenticationEvent {
  @override
  String toString() => "_AuthenticationLogOut";

  @override
  List<Object> get props => [];
}

///
/// Logs the user in anonymously
///
class AuthenticationEventAsAnonymous extends AuthenticationEvent {
  @override
  String toString() {
    return 'AuthenticationEventAsAnonymous{}';
  }

  @override
  List<Object> get props => [];
}

///
/// Logs  the user to out
///
class AuthenticationEventLogout extends AuthenticationEvent {
  @override
  String toString() {
    return 'AuthenticationEventLogout{}';
  }

  @override
  List<Object> get props => [];
}

///
/// Login as a google user with the google login process.
///
class AuthenticationEventAsGoogleUser extends AuthenticationEvent {
  @override
  String toString() {
    return 'AuthenticationEventAsGoogleUser{}';
  }

  @override
  List<Object> get props => [];
}

///
/// This bloc deals with all the pieces related to authentication.
///
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final FirebaseAnalytics analyticsSubsystem;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
      'openid',
    ],
  );

  StreamSubscription<FirebaseUser> _listener;

  @override
  AuthenticationState get initialState {
    return AuthenticationUninitialized();
  }

  AuthenticationBloc({@required this.analyticsSubsystem}) {
    FirebaseAuth.instance
        .currentUser()
        .then((FirebaseUser user) => _authChanged(user));
    _listener = FirebaseAuth.instance.onAuthStateChanged.listen(_authChanged);
  }

  @override
  Future<void> close() async {
    await super.close();
    _listener?.cancel();
  }

  FirebaseUser get currentUser {
    if (state is AuthenticationLoggedIn) {
      return (state as AuthenticationLoggedIn).user;
    }
    return null;
  }

  AuthenticationState _updateWithUser(FirebaseUser user) {
    print("Email not woofed ${user.providerId ?? "frog"}");
    return AuthenticationLoggedIn(user: user);
  }

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is _AuthenticationLogIn) {
      _AuthenticationLogIn loggedInEvent = event;
      var state = _updateWithUser(loggedInEvent.user);
      if (state != null) {
        yield state;
      }
    }

    if (event is _AuthenticationLogOut) {
      try {
        await FirebaseAuth.instance.signOut();
      } catch (e) {
        print("Error $e");
      }
      // Finished logging out.
      yield AuthenticationLoggedOut();
    }

    if (event is AuthenticationEventLogout) {
      FirebaseAuth.instance.signOut();
    }

    if (event is AuthenticationEventAsAnonymous) {
      yield AuthenticationValidating();
      var user = await FirebaseAuth.instance.signInAnonymously();
      if (user != null) {
        // Update the logged in state
        yield AuthenticationLoggedIn(user: user.user);
      } else {
        yield AuthenticationError(reason: LoginFailedReason.InternalError);
      }
    }

    if (event is AuthenticationEventAsGoogleUser) {
      print("LOgin as google usder");
      yield AuthenticationValidating();
      try {
        final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
        if (googleUser != null) {
          final GoogleSignInAuthentication googleAuth =
              await googleUser.authentication;
          final AuthCredential credential = GoogleAuthProvider.getCredential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
          AuthResult result =
              await FirebaseAuth.instance.signInWithCredential(credential);
          var user = result.user;
          assert(!user.isAnonymous);
          if (user != null) {
            assert(await user.getIdToken() != null);

            final FirebaseUser currentUser =
                await FirebaseAuth.instance.currentUser();
            assert(user.uid == currentUser.uid);
            print("Logged in as $user");
            analyticsSubsystem.logLogin();
            yield AuthenticationLoggedIn(user: user);
          } else {
            print('Error: null usders...');

            yield AuthenticationError(reason: LoginFailedReason.BadPassword);
          }
        } else {
          yield AuthenticationError(reason: LoginFailedReason.Cancelled);
        }
      } catch (error) {
        print('Error: $error');
        if (error is PlatformException) {
          switch (error.code) {
            case 'concurrent-requests':
              _googleSignIn.disconnect();
              yield AuthenticationError(
                  reason: LoginFailedReason.InternalError);
              break;
            case 'sign_in_cancelled':
              yield AuthenticationError(reason: LoginFailedReason.Cancelled);
              break;
            default:
              break;
          }
        } else {
          yield AuthenticationError(reason: LoginFailedReason.InternalError);
        }
      }
    }
  }

  void _authChanged(FirebaseUser user) async {
    print("Got user");
    if (user != null) {
      add(_AuthenticationLogIn(user: user));
    } else {
      if (state is AuthenticationLoggedIn ||
          state is AuthenticationUninitialized) {
        add(_AuthenticationLogOut());
      }
    }
  }
}
