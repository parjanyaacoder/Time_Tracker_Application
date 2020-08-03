import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class User {
  final String uid;

  User({@required this.uid});


}
abstract class AuthBase{
  Stream<User> get onAuthStateChanged;
  Future<User> currentUser();
  Future<User> signInAnonymously();
  Future<void> signOut();
  Future<User> signInWithGoogle();
  Future<User> signInWithEmailAndPassword(String email,String password);
  Future<User> createUserWithEmailAndPassword(String email,String password);
}
class Auth implements AuthBase{
  final _firebaseAuth = FirebaseAuth.instance;
  User _userFromFirebase(FirebaseUser user){
    if(user == null)
      return null;
    return User( uid: user.uid);

  }
  @override
  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }
  @override
  Future<User> signInWithEmailAndPassword(String email,String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(authResult.user);
  }
  @override
  Future<User> createUserWithEmailAndPassword(String email,String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> currentUser() async{
    final user =  await _firebaseAuth.currentUser();
    return _userFromFirebase(user);
  }
  @override
  Future<User> signInAnonymously() async{
   final authResult =  await _firebaseAuth.signInAnonymously();
   return _userFromFirebase(authResult.user);
  }
  @override
  Future<void> signOut() async{
  final googleSignIn = GoogleSignIn();
  await googleSignIn.signOut();
   await _firebaseAuth.signOut();
  }
  @override
  Future<User> signInWithGoogle() async{
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount  googleAccount = await googleSignIn.signIn();
    if(googleAccount != null)
    {
      final GoogleSignInAuthentication googleAuth = await googleAccount.authentication;
      if(googleAuth.idToken != null && googleAuth.accessToken!=null)
      {final authResult = await _firebaseAuth.signInWithCredential(GoogleAuthProvider.getCredential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken));
      return _userFromFirebase(authResult.user);}
      else {
        throw PlatformException(
            code: 'Error Missing Google Auth token',
            message: 'Missing Google Auth token'
        );
      }
    }
    else {
      throw PlatformException(
        code: 'Error Aborted by User',
        message: 'Sign In aborted by User'
      );
    }
  }
}