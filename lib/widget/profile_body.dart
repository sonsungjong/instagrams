import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagrams/constants/common_size.dart';
import 'package:instagrams/constants/screen_size.dart';
import 'package:instagrams/screens/profile_screen.dart';
import 'package:instagrams/widget/rounded_avatar.dart';

class ProfileBody extends StatefulWidget {

  final Function onMenuChanged;
  ProfileBody({Key? key, required this.onMenuChanged}) : super(key: key);

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  SelectedTab _selectedTab = SelectedTab.left;
  double _leftImagesPageMargin = 0;
  double _rightImagesPageMargin = size.width;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _appbar(),
          Expanded(
            child: CustomScrollView(
              slivers: [SliverList(
                  delegate: SliverChildListDelegate(
                      [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(common_gap),
                              child: RoundedAvatar(
                                size: 80,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right:common_gap),
                                child: Table(
                                  children: [
                                    TableRow(
                                        children: [
                                          _valueText('123456'),
                                          _valueText('123456'),
                                          _valueText('123456'),
                                        ]
                                    ),
                                    TableRow(
                                      children: [
                                        _labelText('Post'),
                                        _labelText('Followers'),
                                        _labelText('Following')
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        _username(),
                        _userBio(),
                        _editProfileBtn(),
                        _tapButtons(),
                        _selectedIndicator(),
                      ]
                  )
              ),
                _imagesPager()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _appbar() {
    return Row(children:
    [SizedBox(width: 44,),
      Expanded(child: Text('Son SungJong', textAlign: TextAlign.center,)),
      IconButton(onPressed: (){
        widget.onMenuChanged();
      }, icon: Icon(Icons.menu))],
    );
  }

  Text _valueText(String str) => Text(str, style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,);
  Text _labelText(String str) => Text(str, style: TextStyle(fontWeight: FontWeight.w300, fontSize: 11), textAlign: TextAlign.center);

  SliverToBoxAdapter _imagesPager() {
    return SliverToBoxAdapter(
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: duration,
                  transform: Matrix4.translationValues(_leftImagesPageMargin, 0, 0),
                  curve: Curves.fastOutSlowIn,
                  child: _images(),
                ),
                AnimatedContainer(
                  duration: duration,
                  transform: Matrix4.translationValues(_rightImagesPageMargin, 0, 0),
                  curve: Curves.fastOutSlowIn,
                  child: _images(),
                ),
              ]
            )
        );
  }

  GridView _images() {
    return GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(30, (index) => CachedNetworkImage(
                    imageUrl: "https://picsum.photos/id/$index/100/100",
                    fit: BoxFit.cover,
                  )),
                );
  }

  Widget _selectedIndicator(){
    Size size = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      alignment: _selectedTab==SelectedTab.left?Alignment.centerLeft:Alignment.centerRight,
      child: Container(
        height: 3,
        width: size.width/2,
        color: Colors.black87,
      ),
      curve: Curves.fastOutSlowIn,
    );
  }

  Row _tapButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: (){_tabSelected(SelectedTab.left);},
              icon: ImageIcon(
                AssetImage('assets/images/grid.png'),
                color: _selectedTab==SelectedTab.left?Colors.black:Colors.black26,)),
          IconButton(
              onPressed: (){_tabSelected(SelectedTab.right);},
              icon: ImageIcon(
                AssetImage('assets/images/saved.png'),
                color: _selectedTab==SelectedTab.right?Colors.black:Colors.black26,)),
        ],
    );
  }

  _tabSelected(SelectedTab selectedTab){
    setState(() {
      switch(selectedTab){
        case SelectedTab.left:
          _selectedTab = SelectedTab.left;
          _leftImagesPageMargin = 0;
          _rightImagesPageMargin = size.width;
          break;
        case SelectedTab.right:
          _selectedTab = SelectedTab.right;
          _leftImagesPageMargin = -size.width;
          _rightImagesPageMargin = 0;
          break;
      }
    });
  }

  Padding _editProfileBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap, vertical: common_xxs_gap),
      child: SizedBox(
        height:24,
        child: OutlineButton(
          onPressed: (){},
          borderSide: BorderSide(color: Colors.black45),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text('Edit Profile', style: TextStyle(fontWeight: FontWeight.bold),
          ),
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

  Widget _userBio(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap),
      child: Text('this is what I believe',
        style: TextStyle(fontWeight: FontWeight.w400),),
    );
  }
}

enum SelectedTab{
  left, right
}