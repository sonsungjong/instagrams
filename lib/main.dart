import 'package:flutter/material.dart';
import 'package:instagrams/constants/material_white.dart';
import 'package:instagrams/home_page.dart';
import 'package:instagrams/screens/auth_screen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthScreen(),
      //home:HomePage(),
      theme: ThemeData(primarySwatch: white),
    );
  }
}
