
import 'package:flutter/material.dart';
import 'Services/auth.dart';
import 'file:///C:/Users/User/AndroidStudioProjects/time_tracker_application/lib/app/landing_page.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

   return LandingPage(
     auth: Auth(),
   );

  }
}
