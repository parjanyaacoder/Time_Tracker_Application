import 'package:flutter/material.dart';
import 'email_sign_in_form_bloc.dart';

class EmailSignInPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sign In'),
          elevation: 2.0,
          leading: Builder(builder:(BuildContext context){
              return IconButton(
              icon:Icon(Icons.cancel),
            onPressed: (){ Navigator.of(context).pop();});},),

        ),
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(child:EmailSignInFormBloc.create(context)),
          ),
        ),
      ),
    );
  }
}