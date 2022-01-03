import 'package:flutter/material.dart';
import 'package:instagrams/constants/common_size.dart';
import 'package:instagrams/widget/profile_body.dart';

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
            ProfileBody(),
          ],
        ),
      ),
    );
  }

  Row _appbar() {
    return Row(children:
    [SizedBox(width: 44,),
      Expanded(child: Text('Son SungJong', textAlign: TextAlign.center,)),
      IconButton(onPressed: (){}, icon: Icon(Icons.menu))],
    );
  }
}
