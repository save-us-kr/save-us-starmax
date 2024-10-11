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

  Future<Uint8List?> reset() {
    return SaveUsStarmaxPlatform.instance.reset();
  }

  Future<Uint8List?> setState(Map<String, dynamic> param) {
    return SaveUsStarmaxPlatform.instance.setState(param);
  }

  Future<Uint8List?> setTime() {
    return SaveUsStarmaxPlatform.instance.setTime();
  }

  Future<Uint8List?> setUserInfo(Map<String, dynamic> param) {
    return SaveUsStarmaxPlatform.instance.setUserInfo(param);
  }

  Future<Uint8List?> setHeartRateControl(Map<String, dynamic> param) {
    return SaveUsStarmaxPlatform.instance.setHeartRateControl(param);
  }

  Future<Uint8List?> setNotDisturb(Map<String, dynamic> param) {
    return SaveUsStarmaxPlatform.instance.setNotDisturb(param);
  }

  Future<Uint8List?> setLongSit(Map<String, dynamic> param) {
    return SaveUsStarmaxPlatform.instance.setLongSit(param);
  }

  Future<Uint8List?> setDrinkWater(Map<String, dynamic> param) {
    return SaveUsStarmaxPlatform.instance.setDrinkWater(param);
  }

  Future<Uint8List?> getDrinkWater() {
    return SaveUsStarmaxPlatform.instance.getDrinkWater();
  }

  Future<Uint8List?> getLongSit() {
    return SaveUsStarmaxPlatform.instance.getLongSit();
  }

  Future<Uint8List?> getNotDisturb() {
    return SaveUsStarmaxPlatform.instance.getNotDisturb();
  }

  Future<Uint8List?> getSportHistory() {
    return SaveUsStarmaxPlatform.instance.getSportHistory();
  }

  Future<Uint8List?> getValidHistoryDates(Map<String, dynamic> param) {
    return SaveUsStarmaxPlatform.instance.getValidHistoryDates(param);
  }

  Future<Uint8List?> getStepHistory(Map<String, dynamic> param) {
    return SaveUsStarmaxPlatform.instance.getStepHistory(param);
  }

  Future<Uint8List?> getSleepHistory(Map<String, dynamic> param) {
    return SaveUsStarmaxPlatform.instance.getSleepHistory(param);
  }

  Future<Uint8List?> getHeartRateHistory(Map<String, dynamic> param) {
    return SaveUsStarmaxPlatform.instance.getHeartRateHistory(param);
  }

  Future<Uint8List?> getBloodPressureHistory(Map<String, dynamic> param) {
    return SaveUsStarmaxPlatform.instance.getBloodPressureHistory(param);
  }

  Future<Uint8List?> getBloodOxygenHistory(Map<String, dynamic> param) {
    return SaveUsStarmaxPlatform.instance.getBloodOxygenHistory(param);
  }

  Future<Uint8List?> getPressureHistory(Map<String, dynamic> param) {
    return SaveUsStarmaxPlatform.instance.getPressureHistory(param);
  }

  Future<Uint8List?> getMetHistory(Map<String, dynamic> param) {
    return SaveUsStarmaxPlatform.instance.getMetHistory(param);
  }

  Future<Uint8List?> getTempHistory(Map<String, dynamic> param) {
    return SaveUsStarmaxPlatform.instance.getTempHistory(param);
  }

  Future<Uint8List?> getMaiHistory(Map<String, dynamic> param) {
    return SaveUsStarmaxPlatform.instance.getMaiHistory(param);
  }

  Future<Uint8List?> getBloodSugarHistory(Map<String, dynamic> param) {
    return SaveUsStarmaxPlatform.instance.getBloodSugarHistory(param);
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
