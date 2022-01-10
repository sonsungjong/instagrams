import 'package:flutter/material.dart';
import 'package:instagrams/constants/screen_size.dart';
import 'package:instagrams/widget/profile_body.dart';
import 'package:instagrams/widget/profile_side_menu.dart';

const duration = Duration(milliseconds: 300);

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final menuWidth = size.width/3*1;

  MenuStatus _menuStatus = MenuStatus.closed;
  double bodyXPos = 0;
  double menuXPos = size.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body:Stack(
        children:[
          AnimatedContainer(
            duration: duration,
            curve: Curves.fastOutSlowIn,
            child: ProfileBody(onMenuChanged:(){
              setState(() {
                _menuStatus = (_menuStatus == MenuStatus.closed) ? MenuStatus.opend : MenuStatus.closed;
                switch(_menuStatus){
                  case MenuStatus.opend:
                    bodyXPos = -menuWidth;
                    menuXPos = size.width - menuWidth;
                    break;
                  case MenuStatus.closed:
                    bodyXPos = 0;
                    menuXPos = size.width;
                    break;
                }
              });
            }),
            transform: Matrix4.translationValues(bodyXPos, 0, 0),
          ),
          AnimatedContainer(
              duration: duration,
              curve: Curves.fastOutSlowIn,
              transform: Matrix4.translationValues(menuXPos, 0, 0),
              child: ProfileSideMenu(menuWidth)
          ),
        ],
      )
    );
  }
}

enum MenuStatus{
  opend, closed
}