import 'package:flutter/material.dart';

class MyProgressIndicator extends StatelessWidget {

  final double container_size;
  final double progress_size;
  MyProgressIndicator({Key? key, this.container_size = 60, this.progress_size = 60}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: container_size,
      height: container_size,
      child: Center(
        child: SizedBox(
          height: progress_size,
          width: progress_size,
          child: Image.asset('assets/images/loading_img.gif'),
        ),
      ),
    );
  }
}
