import 'package:flutter/material.dart';
import 'package:instagrams/models/camera_state.dart';
import 'package:instagrams/widget/take_photo.dart';
import 'package:provider/provider.dart';

class CameraScreen extends StatefulWidget {
  CameraScreen({Key? key}) : super(key: key);

  CameraState _cameraState = CameraState();

  @override
  _CameraScreenState createState() {
    _cameraState.getReadyToTakePhoto();
    return _CameraScreenState();
  }
}

class _CameraScreenState extends State<CameraScreen> {

  int _currentIndex = 1;
  PageController _pageController = PageController(initialPage: 1);
  String _title = "Photo";

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    widget._cameraState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CameraState>.value(value: widget._cameraState),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: PageView(
          controller: _pageController,
          children: <Widget>[
            Container(
              color: Colors.cyanAccent,
            ),
            TakePhoto(),
            Container(
              color: Colors.greenAccent,
            ),
          ],
          // 탭버튼과 좌우스크롤 연동
          onPageChanged: _connectTabNScroll,
        ),
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 0,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          selectedItemColor: Colors.black87,
          unselectedItemColor: Colors.black54,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.border_bottom_sharp), label: "GALLERY"),
            BottomNavigationBarItem(icon: Icon(Icons.border_bottom_sharp), label: "PHOTO"),
            BottomNavigationBarItem(icon: Icon(Icons.border_bottom_sharp), label: "VIDEO"),
          ],
          // 현재 위치를 변수로 할당
          currentIndex: _currentIndex,
          // 눌린 위치
          onTap: _onItemTabbed,
        ),
      ),
    );
  }

  void _connectTabNScroll(int index){
    print("pageChanged = $index");
    setState(() {
      _currentIndex = index;
      switch(_currentIndex){
        case 0:
          _title = "Gallery";
          break;
        case 1:
          _title = "Photo";
          break;
        case 2:
          _title = "Video";
          break;
      }
    });
  }

  void _onItemTabbed(int index){
    print(index);
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(_currentIndex, duration: Duration(milliseconds: 200), curve: Curves.fastOutSlowIn);
    });
  }
}

