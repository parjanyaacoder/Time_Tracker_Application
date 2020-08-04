
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Services/auth.dart';
import 'file:///C:/Users/User/AndroidStudioProjects/time_tracker_application/lib/app/landing_page.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

   return Provider<AuthBase>(
     builder:(context)=>Auth(),
     child:MaterialApp(
       title: 'Time Tracker',
       theme: ThemeData(primarySwatch: Colors.indigo),
       home: LandingPage(
       ),
     ),
   );

  }
}
