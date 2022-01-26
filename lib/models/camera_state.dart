import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';

class CameraState extends ChangeNotifier{
  late CameraController _controller;
  late CameraDescription _cameraDescription;
  bool _readyTakePhoto = false;

  void dispose(){
    _controller.dispose();
    //_controller = null;
    //_cameraDescription = null;
    _readyTakePhoto = false;
    notifyListeners();
  }

  void getReadyToTakePhoto() async {
    List<CameraDescription> cameras = await availableCameras();

    if(cameras != null && cameras.isNotEmpty){
      setCameraDescription(cameras[0]);
    }
    bool init = false;
    while(!init){
      init = await initialize();
    }
    _readyTakePhoto = true;
    notifyListeners();
  }

  void setCameraDescription(CameraDescription cameraDescription){
    _cameraDescription = cameraDescription;
    _controller = CameraController(_cameraDescription, ResolutionPreset.medium);
  }

  Future<bool> initialize() async{
    try{
      await _controller.initialize();
      return true;
    }catch(e){
      return false;
    }
  }

  CameraController get controller => _controller;
  CameraDescription get description => _cameraDescription;
  bool get isReadyToTakePhoto => _readyTakePhoto;
}


// 1. available camera 가져오기 (Future)
// 2. 카메라 리스트에서 첫번째 카메라 사용
// 3. CameraController 인스턴스 생성
// 4. CameraController.initialize()
// 5. show preview
// 6. set ready to take photo