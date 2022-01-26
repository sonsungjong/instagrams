import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:instagrams/constants/common_size.dart';
import 'package:instagrams/constants/screen_size.dart';
import 'package:instagrams/models/camera_state.dart';
import 'package:instagrams/screens/share_post_screen.dart';
import 'package:instagrams/widget/my_progress_indicator.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class TakePhoto extends StatefulWidget {
  const TakePhoto({
    Key? key,
  }) : super(key: key);

  @override
  State<TakePhoto> createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  Widget _progress = MyProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return Consumer<CameraState>(
      builder: (BuildContext context, CameraState cameraState, Widget? child){
        return Column(
          children: [
            Container(
              width: size.width,
              height: size.width,
              color: Colors.black,
              child: (cameraState.isReadyToTakePhoto) ? _getPreview(cameraState):_progress,
            ),
            Expanded(
              child: OutlineButton(
                onPressed: (){
                  if(cameraState.isReadyToTakePhoto){
                    _attemptTakePhoto(cameraState, context);
                  }
                },
                shape: CircleBorder(),
                borderSide: BorderSide(color: Colors.black12, width: 20),
              ),
            )
          ],
        );
      },
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

  Widget _getPreview(CameraState cameraState) {
    return ClipRect(
      child: OverflowBox(
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Container(
            width: size.width,
            height: size.width/cameraState.controller.value.aspectRatio,
            child: CameraPreview(cameraState.controller),
          ),
        ),
      ),
    );
  }

  void _attemptTakePhoto(CameraState cameraState, BuildContext context) async {
    final String timeInMilli = DateTime.now().millisecondsSinceEpoch.toString();
    try{
      // 파일 저장
      final path = join((await getTemporaryDirectory()).path, '$timeInMilli.png');
      await cameraState.controller.takePicture();
      File imageFile = File(path);
      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SharePostScreen(imageFile)));
    }catch(e){}
  }
}
