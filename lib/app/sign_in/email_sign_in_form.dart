
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_application/Services/auth.dart';
import 'package:time_tracker_application/app/sign_in/validators.dart';
import 'package:time_tracker_application/widgets/form_submit_button.dart';
import 'package:time_tracker_application/widgets/platform_alert_dialog.dart';
import 'package:time_tracker_application/widgets/platoform_exception_alert_dialog.dart';

enum EmailSignInFormType {signIn,register}

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators{



  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final TextEditingController _passwordController = TextEditingController();

  EmailSignInFormType _formType = EmailSignInFormType.signIn;
 String get _email => _emailController.text;
  String get _password => _passwordController.text;
  bool _submitted = false;
  bool _isLoading = false;
  void _submit() async {
    setState(() {
      _submitted = true;_isLoading = true;

    });
    try {
      final auth = Provider.of<AuthBase>(context);
      if (_formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_email, _password);
      }
      else
        await auth.createUserWithEmailAndPassword(_email, _password);
      Navigator.of(context).pop();
    }
    on PlatformException catch(e){
      PlatformExceptionAlertDialog(
         title:'Sign in failed',
         exception: e,
      ).show(context);
      }
    finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _emailEditingComplete() {
    final newFocus = widget.emailvalidator.isValid(_email) ? _passwordFocusNode : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFormType() {
    setState(() {
      _submitted= false;
      _formType = _formType == EmailSignInFormType.signIn ? EmailSignInFormType.register : EmailSignInFormType.signIn ;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren() {

    final primaryText = _formType == EmailSignInFormType.signIn ? 'Sign In':'Create an account';
    final secondaryText = _formType == EmailSignInFormType.signIn ? 'Need an account? Register' : 'Have an account? Register';
    bool submitEnabled = widget.emailvalidator.isValid(_email) && !_isLoading && widget.emailvalidator.isValid(_password);

    return [
      _buildEmailTextField(),
      SizedBox(height: 8.0,),
      _buildPasswordTextField(),
      SizedBox(height: 8.0,),
      FormSubmitButton(
        text:primaryText,
        onPressed: submitEnabled ? _submit : null,
      ),
      SizedBox(height: 8.0,),
      FlatButton(
        child:
          Text(secondaryText),
        onPressed: !_isLoading ? _toggleFormType : null,
      ),
    ];
  }

  TextField _buildPasswordTextField() {
    bool passwordValid = _submitted && !widget.emailvalidator.isValid(_password);
    return TextField(
      focusNode: _passwordFocusNode,
      controller: _passwordController,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: 'Password',
        enabled: _isLoading == false,
        errorText: passwordValid ?   widget.invalidPasswordErrorText :null  ,
      ),
      obscureText: true,
      onChanged: (password) =>  _updateState(),
      onEditingComplete:_submit,
    );
  }

 void  _updateState() {
    setState(() {

    });
  }


  TextField _buildEmailTextField() {
    bool emailValid = _submitted && !widget.emailvalidator.isValid(_email);
    return TextField(
      focusNode: _emailFocusNode,
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email',
        enabled: _isLoading == false,
        hintText: 'abc@email.com',
        errorText: emailValid ?   widget.invalidEmailErrorText :null,

      ),
      autocorrect: false,
      onChanged: (email) =>  _updateState(),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: _emailEditingComplete,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),

      ),
    );
  }
}
