import 'package:flutter/material.dart';
import 'package:instagrams/constants/common_size.dart';
import 'package:instagrams/widget/rounded_avatar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<bool> followings = List.generate(30, (index) => false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.separated(
        itemBuilder: (context, index){
          return ListTile(
            onTap: (){
                setState(() {
                  followings[index] = !followings[index];
                });
            },
            leading: RoundedAvatar(),
            title: Text('손성종 $index'),
            subtitle: Text('user bio number $index'),
            trailing: Container(
              height: 30,
              width: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: followings[index] ? Colors.red[50] : Colors.blue[50],
                border: Border.all(color: followings[index] ? Colors.red : Colors.blue, width: 0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'following',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
        separatorBuilder: (context, index){
          return Divider(color: Colors.grey,);
        },
        itemCount: followings.length,
      )
    );
  }
}
