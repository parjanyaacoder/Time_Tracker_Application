import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_application/Services/auth.dart';
import 'package:time_tracker_application/app/sign_in/sign_in_bloc.dart';
import 'package:time_tracker_application/app/sign_in/social_sign_in_buttons.dart';
import 'package:time_tracker_application/widgets/platoform_exception_alert_dialog.dart';



import 'email_sign_in_page.dart';
import 'sign_in_button.dart';

class SignInPage extends StatelessWidget {
  @required final SignInBloc bloc;

  const SignInPage({Key key, this.bloc}) : super(key: key);


  static Widget create(BuildContext context){
    final auth = Provider.of<AuthBase>(context);
    return Provider<SignInBloc>(
      builder:(context) => SignInBloc(auth),
      dispose: (context,bloc) => bloc.dispose(),
      child: Consumer<SignInBloc>(
          builder:(context,bloc,_)=>SignInPage(bloc: bloc,))
    );
  }



  void _showSignInError(BuildContext context,PlatformException exception){
    PlatformExceptionAlertDialog(
      title: 'Sign in failed',
      exception: exception,
    ).show(context);
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.pushNamed(
       context, '/signIn'
      );}

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      initialRoute: '/',
      routes:
          {
            '/signIn':(context) => EmailSignInPage()
          },
      home: Builder(
        builder:(context)=> Scaffold(
          appBar: AppBar(
            title: Text('Time Tracker'),
            elevation: 2.0,
          ),
          backgroundColor: Colors.grey[200],
          body: StreamBuilder(
              stream: bloc.isLoadingStream,
              initialData: false,
              builder:(context,snapshot){return _buildContent(context,snapshot.data);}),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context,bool isLoading) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
         SizedBox(height:50.0,child: _buildHeader(isLoading)),

          SizedBox(height: 48.0,),
          SocialSignInButton(
            assetName: 'images/google_logo.png',
            text: 'Sign in with Google',
            color: Colors.white,
            onPressed: isLoading ? null : ()=> _signInWithGoogle(context),
            textColor: Colors.black87,
          ),
          SizedBox(height: 8.0,),
          SocialSignInButton(
            assetName: 'images/facebook_logo.png',
            text: 'Sign in with Facebook',
            color: Color(0xFF334D92),
            onPressed: isLoading ? null : _signInWithFacebook,
            textColor: Colors.white,
          ),
          SizedBox(height: 8.0,),

          SignInButton(
            text: 'Sign in with email',
            color: Colors.teal[700],
            onPressed: isLoading ? null : () => { Navigator.pushNamed(
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
            onPressed: isLoading ? null : () async => await _signInAnonymously(context),
            textColor: Colors.black,
          ),

        ],
      ),

    );
  }

 Future<void>  _signInAnonymously(BuildContext context) async {

    try {


    await bloc.signInAnonymously();
    }
    on PlatformException catch (e){
      _showSignInError(context,e);
    }

  }

  void _signInWithGoogle(BuildContext context) async {

    try {
      await bloc.signInWithGoogle();

    }
    on PlatformException catch (e){
      if(e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }

  }


  void _signInWithFacebook() {
  }

  Widget _buildHeader(bool isLoading){
    if(isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  return  Text('Sign In', textAlign: TextAlign.center,
    style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),);
  }

}

