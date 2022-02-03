import 'package:flutter/material.dart';
import 'package:instagrams/constants/material_white.dart';
import 'package:instagrams/home_page.dart';
import 'package:instagrams/models/firebase_auth_state.dart';
import 'package:instagrams/screens/auth_screen.dart';
import 'package:instagrams/widget/my_progress_indicator.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  FirebaseAuthState _firebaseAuthState = FirebaseAuthState();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _firebaseAuthState,
      child: MaterialApp(
        //home: AuthScreen(),
        home:Consumer(
          builder: (BuildContext context, FirebaseAuthState firebaseAuthState, Widget? child){
            switch(firebaseAuthState.firebaseAuthStatus){
              case FirebaseAuthStatus.signout:
                return AuthScreen();
              case FirebaseAuthStatus.signin:
                return HomePage();
              case FirebaseAuthStatus.progress:
                return MyProgressIndicator();
              default:
                return MyProgressIndicator();
            }
          },
          child: HomePage()
        ),
        theme: ThemeData(primarySwatch: white),
      ),
    );
  }
}
