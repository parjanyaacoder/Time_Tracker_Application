import 'package:flutter/material.dart';

import 'auth.dart';

class AuthProvider extends InheritedWidget{
  AuthProvider(this.auth,this.child);
  @required final AuthBase auth;
  @required final Widget child;
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static AuthBase of(BuildContext context){
    AuthProvider provider = context.inheritFromWidgetOfExactType(AuthProvider);
    return provider.auth;
  }
}