import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'save_us_starmax_platform_interface.dart';

/// An implementation of [SaveUsStarmaxPlatform] that uses method channels.
class MethodChannelSaveUsStarmax extends SaveUsStarmaxPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('save_us_starmax');

  @override
  Future<String?> notify(Map<String, dynamic> param) async {
    return await methodChannel.invokeMethod<String>('notify', param);
  }

  @override
  Future<Uint8List?> pairing() async {
    return await methodChannel.invokeMethod<Uint8List>('pair');
  }

  @override
  Future<Uint8List?> reset() async {
    return await methodChannel.invokeMethod<Uint8List>('reset');
  }

  @override
  Future<Uint8List?> setState(Map<String, dynamic> param) async {
    return await methodChannel.invokeMethod<Uint8List>('setState', param);
  }

  @override
  Future<Uint8List?> setTime() async {
    return await methodChannel.invokeMethod('setTime');
  }

  @override
  Future<Uint8List?> setUserInfo(Map<String, dynamic> param) async {
    return await methodChannel.invokeMethod('setUserInfo', param);
  }

  @override
  Future<Uint8List?> setHeartRateControl(Map<String, dynamic> param) async {
    return await methodChannel.invokeMethod('setHeartRateControl', param);
  }

  @override
  Future<Uint8List?> setNotDisturb(Map<String, dynamic> param) async {
    return await methodChannel.invokeMethod('setNotDisturb', param);
  }

  @override
  Future<Uint8List?> setLongSit(Map<String, dynamic> param) async {
    return await methodChannel.invokeMethod('setLongSit', param);
  }

  @override
  Future<Uint8List?> setDrinkWater(Map<String, dynamic> param) async {
    return await methodChannel.invokeMethod('setDrinkWater', param);
  }

  @override
  Future<Uint8List?> getDrinkWater() async {
    return await methodChannel.invokeMethod('getDrinkWater');
  }

  @override
  Future<Uint8List?> getLongSit() async {
    return await methodChannel.invokeMethod('getLongSit');
  }

  @override
  Future<Uint8List?> getNotDisturb() async {
    return await methodChannel.invokeMethod('getNotDisturb');
  }

  @override
  Future<Uint8List?> getSportHistory() async {
    return await methodChannel.invokeMethod('getSportHistory');
  }

  @override
  Future<Uint8List?> getValidHistoryDates(Map<String, dynamic> param) async {
    return await methodChannel.invokeMethod('getValidHistoryDates', param);
  }

  @override
  Future<Uint8List?> getStepHistory(Map<String, dynamic> param) async {
    return await methodChannel.invokeMethod('getStepHistory', param);
  }

  @override
  Future<Uint8List?> getHeartRateHistory(Map<String, dynamic> param) async {
    return await methodChannel.invokeMethod('getHeartRateHistory', param);
  }

  @override
  Future<Uint8List?> getBloodPressureHistory(Map<String, dynamic> param) async {
    return await methodChannel.invokeMethod('getBloodPressureHistory', param);
  }

  @override
  Future<Uint8List?> getBloodOxygenHistory(Map<String, dynamic> param) async {
    return await methodChannel.invokeMethod('getBloodOxygenHistory', param);
  }

  @override
  Future<Uint8List?> getPressureHistory(Map<String, dynamic> param) async {
    return await methodChannel.invokeMethod('getPressureHistory', param);
  }

  @override
  Future<Uint8List?> getMetHistory(Map<String, dynamic> param) async {
    return await methodChannel.invokeMethod('getMetHistory', param);
  }

  @override
  Future<Uint8List?> getTempHistory(Map<String, dynamic> param) async {
    return await methodChannel.invokeMethod('getTempHistory', param);
  }

  @override
  Future<Uint8List?> getMaiHistory(Map<String, dynamic> param) async {
    return await methodChannel.invokeMethod('getMaiHistory', param);
  }

  @override
  Future<Uint8List?> getBloodSugarHistory(Map<String, dynamic> param) async {
    return await methodChannel.invokeMethod('getBloodSugarHistory', param);
  }

  @override
  Future<Uint8List?> getHeartRateControl() async {
    return await methodChannel.invokeMethod('getHeartRateControl');
  }

  @override
  Future<Uint8List?> getHealthData() async {
    return await methodChannel.invokeMethod<Uint8List>('getHealthData');
  }

  @override
  Future<Uint8List?> getHealthOpen() async {
    return await methodChannel.invokeMethod<Uint8List>('getHealthOpen');
  }

  @override
  Future<Uint8List?> getState() async {
    return await methodChannel.invokeMethod<Uint8List>('getState');
  }

  @override
  Future<Uint8List?> getPower() async {
    return await methodChannel.invokeMethod('getPower');
  }

  @override
  Future<Uint8List?> getVersion() async {
    return await methodChannel.invokeMethod('getVersion');
  }

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
