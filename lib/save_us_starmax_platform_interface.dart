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

  Future<Uint8List?> reset() {
    throw UnimplementedError();
  }

  Future<Uint8List?> setState(Map<String, dynamic> param) {
    throw UnimplementedError();
  }

  Future<Uint8List?> setTime() {
    throw UnimplementedError();
  }

  Future<Uint8List?> setUserInfo(Map<String, dynamic> param) {
    throw UnimplementedError();
  }

  Future<Uint8List?> setHeartRateControl(Map<String, dynamic> param) {
    throw UnimplementedError();
  }

  Future<Uint8List?> setNotDisturb(Map<String, dynamic> param) {
    throw UnimplementedError();
  }

  Future<Uint8List?> setLongSit(Map<String, dynamic> param) {
    throw UnimplementedError();
  }

  Future<Uint8List?> setDrinkWater(Map<String, dynamic> param) {
    throw UnimplementedError();
  }

  Future<Uint8List?> getDrinkWater() {
    throw UnimplementedError();
  }

  Future<Uint8List?> getLongSit() {
    throw UnimplementedError();
  }

  Future<Uint8List?> getNotDisturb() {
    throw UnimplementedError();
  }

  Future<Uint8List?> getSportHistory() {
    throw UnimplementedError();
  }

  Future<Uint8List?> getValidHistoryDates(Map<String, dynamic> param) {
    throw UnimplementedError();
  }

  Future<Uint8List?> getStepHistory(Map<String, dynamic> param) {
    throw UnimplementedError();
  }

  Future<Uint8List?> getSleepHistory(Map<String, dynamic> param) {
    throw UnimplementedError();
  }

  Future<Uint8List?> getHeartRateHistory(Map<String, dynamic> param) {
    throw UnimplementedError();
  }

  Future<Uint8List?> getBloodPressureHistory(Map<String, dynamic> param) {
    throw UnimplementedError();
  }

  Future<Uint8List?> getBloodOxygenHistory(Map<String, dynamic> param) {
    throw UnimplementedError();
  }

  Future<Uint8List?> getPressureHistory(Map<String, dynamic> param) {
    throw UnimplementedError();
  }

  Future<Uint8List?> getMetHistory(Map<String, dynamic> param) {
    throw UnimplementedError();
  }

  Future<Uint8List?> getTempHistory(Map<String, dynamic> param) {
    throw UnimplementedError();
  }

  Future<Uint8List?> getMaiHistory(Map<String, dynamic> param) {
    throw UnimplementedError();
  }

  Future<Uint8List?> getBloodSugarHistory(Map<String, dynamic> param) {
    throw UnimplementedError();
  }

  Future<Uint8List?> getHeartRateControl() {
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
