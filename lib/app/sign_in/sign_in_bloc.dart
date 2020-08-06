import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:time_tracker_application/Services/auth.dart';

class SignInBloc {
  final ValueNotifier<bool> isLoading;
  @required final AuthBase auth;
  SignInBloc(this.auth,this.isLoading);
 Future<User> _signIn(Future<User> Function() signInMethod) async{
  try{
  isLoading.value = true;
  return await signInMethod();
  }catch (e){
  rethrow;
  }finally{
    isLoading.value = false;
  }
}
  Future<User> signInAnonymously() async => await _signIn(auth.signInAnonymously);
  Future<User> signInWithGoogle() async => await _signIn(auth.signInWithGoogle);


}