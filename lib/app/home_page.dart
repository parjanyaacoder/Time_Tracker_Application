import 'package:flutter/material.dart';
import 'package:time_tracker_application/Services/auth.dart';
import 'package:time_tracker_application/widgets/platform_alert_dialog.dart';
class HomePage extends StatelessWidget {



  final AuthBase auth;
  const HomePage({@required this.auth,});
  Future<void>  _signOut() async {
    try {
      await auth.signOut();
    }
    catch (e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home : Scaffold(
        appBar: AppBar(
          title:Text('Home Page'),
          actions: <Widget>[
            FlatButton(
              child: Text('Logout',style: TextStyle(fontSize: 15.0,color:Colors.white),),
              onPressed:  _signOut,
            )

          ],
        ),
      ),
    );
  }
}
