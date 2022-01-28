import 'package:flutter/foundation.dart';
import 'package:local_image_provider/local_image.dart';
import 'package:local_image_provider/local_image_provider.dart';

class GalleryState extends ChangeNotifier{
  late LocalImageProvider _localImageProvider;
  late bool _hasPermission;
  late List<LocalImage> _images;

  Future<bool> initProvider() async {
    _localImageProvider = LocalImageProvider();
    _hasPermission = await _localImageProvider.initialize();

    if(_hasPermission){
      _images = await _localImageProvider.findLatest(30);
      notifyListeners();
      return true;
    }else{return false;}
  }

  // 밖으로 전달할 수 있게 만듦
  List<LocalImage> get images => _images;
  LocalImageProvider get localImageProvider => _localImageProvider;
}