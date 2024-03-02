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
  Future<Uint8List?> setTime() async {
    return await methodChannel.invokeMethod('setTime');
  }

  @override
  Future<Uint8List?> setHeartRateControl(Map<String, dynamic> param) async {
    return await methodChannel.invokeMethod('setHeartRateControl', param);
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
