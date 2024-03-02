import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'save_us_starmax_method_channel.dart';

abstract class SaveUsStarmaxPlatform extends PlatformInterface {
  /// Constructs a SaveUsStarmaxPlatform.
  SaveUsStarmaxPlatform() : super(token: _token);

  static final Object _token = Object();

  static SaveUsStarmaxPlatform _instance = MethodChannelSaveUsStarmax();

  /// The default instance of [SaveUsStarmaxPlatform] to use.
  ///
  /// Defaults to [MethodChannelSaveUsStarmax].
  static SaveUsStarmaxPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SaveUsStarmaxPlatform] when
  /// they register themselves.
  static set instance(SaveUsStarmaxPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> notify(Map<String, dynamic> param) {
    throw UnimplementedError();
  }

  Future<Uint8List?> pairing() {
    throw UnimplementedError();
  }

  Future<Uint8List?> setTime() {
    throw UnimplementedError();
  }

  Future<Uint8List?> setHeartRateControl(Map<String, dynamic> param) async {
    throw UnimplementedError();
  }

  Future<Uint8List?> getHeartRateControl() async {
    throw UnimplementedError();
  }

  Future<Uint8List?> getHealthData() {
    throw UnimplementedError();
  }

  Future<Uint8List?> getHealthOpen() {
    throw UnimplementedError();
  }

  Future<Uint8List?> getState() {
    throw UnimplementedError();
  }

  Future<Uint8List?> getPower() {
    throw UnimplementedError();
  }

  Future<Uint8List?> getVersion() async {
    throw UnimplementedError();
  }
}
