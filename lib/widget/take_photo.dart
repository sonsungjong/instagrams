import 'package:flutter/material.dart';
import 'package:instagrams/constants/common_size.dart';
import 'package:instagrams/constants/screen_size.dart';

class TakePhoto extends StatelessWidget {
  const TakePhoto({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size.width,
          height: size.width,
          color: Colors.black,
        ),
        Expanded(
          child: OutlineButton(
            onPressed: (){},
            shape: CircleBorder(),
            borderSide: BorderSide(color: Colors.black12, width: 20),
          ),
        )
      ],
    );
  }

  // 해당 공간을 클릭이 가능하게 만드는 위젯(InkWell)
  InkWell _clickSpace() {
    return InkWell(
      onTap: (){},
      child: Padding(
        padding: const EdgeInsets.all(common_s_gap),
        child: Container(
          decoration: ShapeDecoration(
            shape: CircleBorder(
              side: BorderSide(
                color: Colors.black12,
                width: 20,
              )
            ),
          ),
        ),
      ),
    );
  }
}
