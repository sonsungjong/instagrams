import 'package:flutter/material.dart';
import 'package:instagrams/screens/camera_screen.dart';
import 'package:instagrams/screens/feed_screen.dart';
import 'package:instagrams/screens/profile_screen.dart';
import 'package:permission_handler/permission_handler.dart';

import 'constants/screen_size.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BottomNavigationBarItem> btmNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),             // 0
    BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),           // 1
    BottomNavigationBarItem(icon: Icon(Icons.add), label: ""),              // 2
    BottomNavigationBarItem(icon: Icon(Icons.healing), label: ""),          // 3
    BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: ""),   // 4
  ];

  int _selectedIndex = 0;
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  static List<Widget> _screens = <Widget>[
    FeedScreen(),                                   // 0
    Container(color: Colors.blueAccent),            // 1
    Container(color: Colors.greenAccent),           // 2
    Container(color: Colors.deepPurpleAccent),      // 3
    ProfileScreen(),                                // 4
  ];

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      key: _key,
      body: IndexedStack(
        index : _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: btmNavItems,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black87,
        currentIndex: _selectedIndex,
        onTap: _onBtmItemClick,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
  void _onBtmItemClick(int index){
    print(index);
    switch(index){
      case 2:
        _openCamera();
        break;
      default:
        setState((){
          _selectedIndex = index;
        });
    }
  }

  void _openCamera() async{
    if(await checkIfPermissionGranted(context)) {
      // 새창 띄우는 방법
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => CameraScreen()));
    }else{
      SnackBar snackBar = SnackBar(
        content: Text("사진, 파일, 마이크 접근 허용시 카메라 사용 가능"),
        action: SnackBarAction(
          label: "OK",
          onPressed: (){
            _key.currentState!.hideCurrentSnackBar();
          },
        ),
      );
      _key.currentState!.showSnackBar(snackBar);
    }
  }

  Future<bool> checkIfPermissionGranted(BuildContext context) async{
    Map<Permission, PermissionStatus> statuses =
        await [Permission.camera, Permission.microphone].request();
    bool permitted = true;

    statuses.forEach((permission, permissionStatus) {
      if(!permissionStatus.isGranted) permitted = false;
    });

    return permitted;
  }
}

