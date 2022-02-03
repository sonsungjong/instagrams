import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthState extends ChangeNotifier{
  FirebaseAuthStatus _firebaseAuthStatus = FirebaseAuthStatus.progress;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late User _user;

  void watchAuthChange(){
    _firebaseAuth.authStateChanges().listen((user){
      if(user == null && _user == null){
        return;
      }else if(user != _user){
        _user = user!;
        changeFirebaseAuthStatus();
      }
    });
  }

  void changeFirebaseAuthStatus([FirebaseAuthStatus? firebaseAuthStatus]){
    if(firebaseAuthStatus != null){
      _firebaseAuthStatus = firebaseAuthStatus;
    }else{
      if(_user != null){
        _firebaseAuthStatus = FirebaseAuthStatus.signin;
      }else{
        _firebaseAuthStatus = FirebaseAuthStatus.signout;
      }
    }
    notifyListeners();
  }
  FirebaseAuthStatus get firebaseAuthStatus=>_firebaseAuthStatus;
}

enum FirebaseAuthStatus{
  signout, progress, signin
}

// FirebaseUser -> User
// AuthResult -> UserCredential
// currentUser() -> currentUser
// onAuthStateChanged -> authStateChages()