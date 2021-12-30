import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagrams/constants/common_size.dart';
import 'package:instagrams/widget/comment.dart';
import 'package:instagrams/widget/my_progress_indicator.dart';
import 'package:instagrams/widget/rounded_avatar.dart';

class Post extends StatelessWidget {
  final int index;

  Post(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _postHeader(),
        _postImage(),
        _postActions(),
        _postLikes(),
        _postCaption()
      ],
    );
  }

  Widget _postCaption(){
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal:common_gap,
        vertical: common_gap
      ),
      child: Comment(
        show_image: false,
        username: 'test user',
        text: 'I am test user!',
        date_time: DateTime.now(),
      ),
    );
  }

  Padding _postLikes() {
    return Padding(
          padding: const EdgeInsets.only(left: common_gap),
          child:Text('12000 likes', style: TextStyle(fontWeight: FontWeight.bold),
          ),
      );
  }

  Row _postActions() {
    return Row(
        children: [
          IconButton(
            icon: ImageIcon(AssetImage('assets/images/bookmark.png')),
            color: Colors.black87,
            onPressed: null,
          ),
          IconButton(
            icon: ImageIcon(AssetImage('assets/images/comment.png')),
            color: Colors.black87,
            onPressed: null,
          ),
          IconButton(
            icon: ImageIcon(AssetImage('assets/images/direct_message.png')),
            color: Colors.black87,
            onPressed: null,
          ),
          Spacer(),
          IconButton(
            icon: ImageIcon(AssetImage('assets/images/heart_selected.png')),
            color: Colors.black87,
            onPressed: null,
          ),
        ],
      );
  }

  Widget _postHeader(){
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(common_xxs_gap),
          child: RoundedAvatar(),
        ),
        Expanded(child:Text('username')),
        IconButton(
            onPressed: null,
            icon: Icon(Icons.more_horiz, color:Colors.black87)
        )
      ],
    );
  }

  CachedNetworkImage _postImage() {
    return CachedNetworkImage(
        imageUrl: 'https://picsum.photos/id/$index/200/200',
        placeholder:
          (BuildContext context, String url){
            return MyProgressIndicator(container_size: MediaQuery.of(context).size.width,);
          },
        imageBuilder: (BuildContext context, ImageProvider imageProvider){
          return AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover
                ),
              ),
            ),
          );
        },
      );
  }
}




