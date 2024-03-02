import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'save_us_starmax_platform_interface.dart';

class SaveUsStarmax {
  Future<String?> getPlatformVersion() {
    return SaveUsStarmaxPlatform.instance.getPlatformVersion();
  }

  Future<String?> notify(Map<String, dynamic> param) {
    return SaveUsStarmaxPlatform.instance.notify(param);
  }

  Future<Uint8List?> pairing() {
    return SaveUsStarmaxPlatform.instance.pairing();
  }

  Future<Uint8List?> setTime() async {
    return SaveUsStarmaxPlatform.instance.setTime();
  }

  Future<Uint8List?> setHeartRateControl(Map<String, dynamic> param) async {
    return SaveUsStarmaxPlatform.instance.setHeartRateControl(param);
  }

  Future<Uint8List?> getHeartRateControl() async {
    return SaveUsStarmaxPlatform.instance.getHeartRateControl();
  }

  Future<Uint8List?> getHealthData() {
    return SaveUsStarmaxPlatform.instance.getHealthData();
  }

  Future<Uint8List?> getHealthOpen() {
    return SaveUsStarmaxPlatform.instance.getHealthOpen();
  }

  Future<Uint8List?> getState() {
    return SaveUsStarmaxPlatform.instance.getState();
  }

  Future<Uint8List?> getPower() {
    return SaveUsStarmaxPlatform.instance.getPower();
  }

  Future<Uint8List?> getVersion() async {
    return SaveUsStarmaxPlatform.instance.getVersion();
  }
}
