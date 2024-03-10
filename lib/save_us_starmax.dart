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

  Future<Uint8List?> setTime() {
    return SaveUsStarmaxPlatform.instance.setTime();
  }

  Future<Uint8List?> setHeartRateControl(Map<String, dynamic> param) {
    return SaveUsStarmaxPlatform.instance.setHeartRateControl(param);
  }

  Future<Uint8List?> getSportHistory() {
    return SaveUsStarmaxPlatform.instance.getSportHistory();
  }

  Future<Uint8List?> getValidHistoryDates() {
    return SaveUsStarmaxPlatform.instance.getValidHistoryDates();
  }

  Future<Uint8List?> getStepHistory() {
    return SaveUsStarmaxPlatform.instance.getStepHistory();
  }

  Future<Uint8List?> getHeartRateHistory() {
    return SaveUsStarmaxPlatform.instance.getHeartRateHistory();
  }

  Future<Uint8List?> getBloodPressureHistory() {
    return SaveUsStarmaxPlatform.instance.getBloodPressureHistory();
  }

  Future<Uint8List?> getBloodOxygenHistory() {
    return SaveUsStarmaxPlatform.instance.getBloodOxygenHistory();
  }

  Future<Uint8List?> getPressureHistory() {
    return SaveUsStarmaxPlatform.instance.getPressureHistory();
  }

  Future<Uint8List?> getMetHistory() {
    return SaveUsStarmaxPlatform.instance.getMetHistory();
  }

  Future<Uint8List?> getTempHistory() {
    return SaveUsStarmaxPlatform.instance.getTempHistory();
  }

  Future<Uint8List?> getMaiHistory() {
    return SaveUsStarmaxPlatform.instance.getMaiHistory();
  }

  Future<Uint8List?> getBloodSugarHistory() {
    return SaveUsStarmaxPlatform.instance.getBloodSugarHistory();
  }

  Future<Uint8List?> getHeartRateControl() {
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

  Future<Uint8List?> getVersion() {
    return SaveUsStarmaxPlatform.instance.getVersion();
  }
}
