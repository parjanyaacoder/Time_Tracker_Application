import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_application/Services/auth.dart';


class HomePage extends StatelessWidget {

  Future<void>  _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context);
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
              onPressed: () => _signOut(context),
            )

          ],
        ),
      ),
    );
  }
}
