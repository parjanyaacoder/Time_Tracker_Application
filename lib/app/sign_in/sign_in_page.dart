import 'package:flutter/material.dart';
import 'package:time_tracker_application/Services/auth.dart';
import 'package:time_tracker_application/app/sign_in/social_sign_in_buttons.dart';



import 'email_sign_in_page.dart';
import 'sign_in_button.dart';

class SignInPage extends StatelessWidget {

  void _signInWithEmail(BuildContext context) {
    Navigator.pushNamed(
       context, '/signIn'
      );}
  final AuthBase auth;
  const SignInPage({@required this.auth,}) ;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes:
          {
            '/signIn':(context) => EmailSignInPage(auth: auth,)
          },
      home: Builder(
        builder:(context)=> Scaffold(
          appBar: AppBar(
            title: Text('Time Tracker'),
            elevation: 2.0,
          ),
          backgroundColor: Colors.grey[200],
          body: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          Text('Sign In', textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),),
          SizedBox(height: 48.0,),
          SocialSignInButton(
            assetName: 'images/google_logo.png',
            text: 'Sign in with Google',
            color: Colors.white,
            onPressed: _signInWithGoogle,
            textColor: Colors.black87,
          ),
          SizedBox(height: 8.0,),
          SocialSignInButton(
            assetName: 'images/facebook_logo.png',
            text: 'Sign in with Facebook',
            color: Color(0xFF334D92),
            onPressed: _signInWithFacebook,
            textColor: Colors.white,
          ),
          SizedBox(height: 8.0,),

          SignInButton(
            text: 'Sign in with email',
            color: Colors.teal[700],
            onPressed: () => { Navigator.pushNamed(
            context, '/signIn'
            )},
            textColor: Colors.white,
          ),
          SizedBox(height: 8.0,),
          Text('Or', textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.0,
                fontWeight: FontWeight.w100,
                color: Colors.black87),),
          SizedBox(height: 8.0,),
          SignInButton(
            text: 'Go anonymous',
            color: Colors.lime[300],
            onPressed: () async => await _signInAnonymously(),
            textColor: Colors.black,
          ),

        ],
      ),

    );
  }

 Future<void>  _signInAnonymously() async {
    try {
    await auth.signInAnonymously();

    }
    catch (e){
      print(e.toString());
    }
  }


  void _signInWithGoogle() async {
    try {
      await auth.signInWithGoogle();

    }
    catch (e){
      print(e.toString());
    }
  }

  void _signInWithFacebook() {
  }


}