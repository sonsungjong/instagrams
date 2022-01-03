import 'package:flutter/material.dart';
import 'package:instagrams/screens/feed_screen.dart';
import 'package:instagrams/screens/profile_screen.dart';

import 'constants/screen_size.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BottomNavigationBarItem> btmNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
    BottomNavigationBarItem(icon: Icon(Icons.add), label: ""),
    BottomNavigationBarItem(icon: Icon(Icons.healing), label: ""),
    BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: ""),
  ];

  int _selectedIndex = 0;

  static List<Widget> _screens = <Widget>[
    FeedScreen(),
    Container(color: Colors.blueAccent),
    Container(color: Colors.greenAccent),
    Container(color: Colors.deepPurpleAccent),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
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
    setState((){
      _selectedIndex = index;
    });
  }
}

