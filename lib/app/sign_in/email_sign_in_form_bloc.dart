

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_application/Services/auth.dart';
import 'package:time_tracker_application/app/sign_in/validators.dart';
import 'package:time_tracker_application/widgets/form_submit_button.dart';

import 'package:time_tracker_application/widgets/platoform_exception_alert_dialog.dart';

import 'email_sign_in_bloc.dart';
import 'email_sign_in_model.dart';



class EmailSignInFormBloc extends StatefulWidget with EmailAndPasswordValidators{

  @required final EmailSignInBloc bloc;

   EmailSignInFormBloc({Key key, this.bloc}) : super(key: key);
   static Widget create(BuildContext context){
     final AuthBase auth = Provider.of<AuthBase>(context);
     return Provider<EmailSignInBloc>(
       builder: (context) => EmailSignInBloc(auth),
       child: Consumer<EmailSignInBloc>(
           builder:(context,bloc,_)=> EmailSignInFormBloc(bloc: bloc,),

       ),
       dispose: (context,bloc)=>bloc.dispose(),
     );
   }
  @override
  _EmailSignInFormBlocState createState() => _EmailSignInFormBlocState();
}

class _EmailSignInFormBlocState extends State<EmailSignInFormBloc> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final TextEditingController _passwordController = TextEditingController();


  @override
  void dispose(){
    _emailFocusNode.dispose();
    _emailController.dispose();
    _passwordFocusNode.dispose();
    _passwordController.dispose();

    super.dispose();
  }
  
  void _submit() async {

    try {
      await widget.bloc.submit();
      Navigator.of(context).pop();
    }
    on PlatformException catch(e){
      PlatformExceptionAlertDialog(
         title:'Sign in failed',
         exception: e,
      ).show(context);
      }

  }

  void _emailEditingComplete(EmailSignInModel model) {
    final newFocus = widget.emailvalidator.isValid(model.email) ? _passwordFocusNode : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFormType(EmailSignInModel model) {
   widget.bloc.toggleFormType(
   );
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren(EmailSignInModel model) {

    final primaryText = model.formType == EmailSignInFormType.signIn ? 'Sign In':'Create an account';
    final secondaryText = model.formType == EmailSignInFormType.signIn ? 'Need an account? Register' : 'Have an account? Register';
    bool submitEnabled = widget.emailvalidator.isValid(model.email) && !model.isLoading && widget.emailvalidator.isValid(model.password);

    return [
      _buildEmailTextField(model),
      SizedBox(height: 8.0,),
      _buildPasswordTextField(model),
      SizedBox(height: 8.0,),
      FormSubmitButton(
        text:primaryText,
        onPressed: submitEnabled ? _submit : null,
      ),
      SizedBox(height: 8.0,),
      FlatButton(
        child:
          Text(secondaryText),
        onPressed: !model.isLoading ? () => _toggleFormType(model) : null,
      ),
    ];
  }

  TextField _buildPasswordTextField(EmailSignInModel model) {
    bool passwordValid = model.submitted && !widget.emailvalidator.isValid(model.password);
    return TextField(
      focusNode: _passwordFocusNode,
      controller: _passwordController,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: 'Password',
        enabled: model.isLoading == false,
        errorText: passwordValid ?   widget.invalidPasswordErrorText :null  ,
      ),
      obscureText: true,
      onChanged:   widget.bloc.updatePassword,
      onEditingComplete:_submit,
    );
  }




  TextField _buildEmailTextField(EmailSignInModel model) {
    bool emailValid = model.submitted && !widget.emailvalidator.isValid(model.email);
    return TextField(
      focusNode: _emailFocusNode,
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email',
        enabled: model.isLoading == false,
        hintText: 'abc@email.com',
        errorText: emailValid ?   widget.invalidEmailErrorText :null,

      ),
      autocorrect: false,
      onChanged: widget.bloc.updateEmail,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete:() => _emailEditingComplete(model),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailSignInModel>(
     stream: widget.bloc.modelStream,
      initialData: EmailSignInModel(),
      builder:(context,snapshot) {
       final EmailSignInModel model = snapshot.data;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: _buildChildren(model),

          ),
        );
      },
    );
  }
}
