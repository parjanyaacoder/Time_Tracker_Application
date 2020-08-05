
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_application/Services/auth.dart';
import 'package:time_tracker_application/app/sign_in/sign_in_page.dart';

import 'home_page.dart';
class LandingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final auth = Provider.of<AuthBase>(context);
    return StreamBuilder<User>(
      stream: auth.onAuthStateChanged,
      // ignore: missing_return
      builder:(context, snapshot) {

        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            return SignInPage.create(context);
          }
          return HomePage(
          );
        }
        else {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      });

  }
}
