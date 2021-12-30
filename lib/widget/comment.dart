import 'package:flutter/material.dart';
import 'package:instagrams/constants/common_size.dart';
import 'package:instagrams/widget/rounded_avatar.dart';

class Comment extends StatelessWidget {

  final bool show_image;
  final String username;
  final String text;
  final DateTime date_time;

  Comment({
    Key? key, this.show_image=true, required this.username, required this.text, required this.date_time
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if(show_image) RoundedAvatar(size: 24),
        if(show_image) SizedBox(width: common_xxs_gap,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: username,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        )
                    ),
                    TextSpan(
                        text: '  '
                    ),
                    TextSpan(
                      text: text,
                      style: TextStyle(
                          color: Colors.black87
                      ),
                    )
                  ] ,
                )
            ),
            if (date_time != null)
              Text(
                date_time.toIso8601String(),
                style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 10
                ),
              )
          ],
        ),
      ],
    );
  }
}