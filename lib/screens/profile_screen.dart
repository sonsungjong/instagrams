import 'package:flutter/material.dart';
import 'package:instagrams/constants/common_size.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _appbar(),
            _username(),
          ],
        ),
      ),
    );
  }

  Widget _username(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap),
      child: Text('this is user name',
        style: TextStyle(fontWeight: FontWeight.bold),),
    );
  }

  Row _appbar() {
    return Row(
            children: [
              SizedBox(width: 44,),
              Expanded(child: Text('Son SungJong', textAlign: TextAlign.center,)),
              IconButton(onPressed: (){}, icon: Icon(Icons.menu))
            ],
          );
  }
}
