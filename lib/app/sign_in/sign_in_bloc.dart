import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:time_tracker_application/Services/auth.dart';

class SignInBloc {

  @required final AuthBase auth;
  SignInBloc(this.auth);

  final StreamController<bool> _isLoadingController = StreamController<bool>();


  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  void dispose(){
    _isLoadingController.close();
  }
  void _setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);
  Future<User> _signIn(Future<User> Function() signInMethod) async{
  try{
  _setIsLoading(true);
  return await signInMethod();
  }catch (e){
  rethrow;
  }finally{
  _setIsLoading(false);
  }
}
  Future<User> signInAnonymously() async => await _signIn(auth.signInAnonymously);
  Future<User> signInWithGoogle() async => await _signIn(auth.signInWithGoogle);


}