import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:time_tracker_application/Services/auth.dart';
import 'package:time_tracker_application/app/sign_in/email_sign_in_model.dart';

class EmailSignInBloc {
  @required final AuthBase auth;
  final StreamController<EmailSignInModel> _modelController = StreamController<EmailSignInModel>();

  EmailSignInBloc(this.auth);
  Stream<EmailSignInModel> get modelStream => _modelController.stream;
  EmailSignInModel _model = EmailSignInModel();
  void dispose() {
    _modelController.close();
  }
  void toggleFormType() {
    final formType =  _model.formType == EmailSignInFormType.signIn ? EmailSignInFormType.register:EmailSignInFormType.signIn;
    updateWith(
        email: '',
        password: '',
        isLoading: false,
        submitted: false,formType:formType,
    );
  }
  void updateEmail(String email) => updateWith(email: email);
  void updatePassword(String password) => updateWith(password: password);

  Future<void> submit() async {
    updateWith(submitted: true,isLoading: true,);
    try {

      if (_model.formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_model.email, _model.password);
      }
      else
        await auth.createUserWithEmailAndPassword(_model.email, _model.password);

    }
    catch(e){
      rethrow ;
    }
    finally {
      updateWith(isLoading: false,);
    }
  }


  void updateWith({
  String email,
    String password,
    bool isLoading,
    bool submitted,
    EmailSignInFormType formType
}) {
       _model = _model.copyWith(
         email: email,
         formType: formType,
         password: password,
         isLoading: isLoading,
         submitted: submitted,

       );
       _modelController.add(_model);
  }

}