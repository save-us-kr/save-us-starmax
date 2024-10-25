import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:save_us_starmax/save_us_starmax.dart';
import 'package:save_us_starmax/save_us_starmax_method_channel.dart';
import 'package:save_us_starmax/save_us_starmax_platform_interface.dart';

class MockSaveUsStarmaxPlatform
    with MockPlatformInterfaceMixin
    implements SaveUsStarmaxPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<String?> notify(Map<String, dynamic> param) {
    return Future.value('');
  }

  @override
  Future<Uint8List?> pairing() {
    return Future.value(Uint8List(16));
  }

  @override
  Future<Uint8List?> reset() {
    return Future.value(Uint8List(16));
  }

  @override
  Future<Uint8List?> setState(Map<String, dynamic> param) {
    return Future.value(Uint8List(16));
  }

  @override
  Future<Uint8List?> setTime() {
    return Future.value(Uint8List(16));
  }

  @override
  Future<Uint8List?> setUserInfo(Map<String, dynamic> param) {
    return Future.value(Uint8List(16));
  }

  @override
  Future<Uint8List?> setNotDisturb(Map<String, dynamic> param) {
    return Future.value(Uint8List(16));
  }

  @override
  Future<Uint8List?> setLongSit(Map<String, dynamic> param) {
    return Future.value(Uint8List(16));
  }

  @override
  Future<Uint8List?> setDrinkWater(Map<String, dynamic> param) {
    return Future.value(Uint8List(16));
  }

  @override
  Future<Uint8List?> getDrinkWater() {
    return Future.value(Uint8List(16));
  }

  @override
  Future<Uint8List?> getLongSit() {
    return Future.value(Uint8List(16));
  }

  @override
  Future<Uint8List?> getNotDisturb() {
    return Future.value(Uint8List(16));
  }

  @override
  Future<Uint8List?> getState() {
    return Future.value(Uint8List(16));
  }

  @override
  Future<Uint8List?> getPower() {
    return Future.value(Uint8List(16));
  }

  @override
  Future<Uint8List?> getVersion() {
    return Future.value(Uint8List(16));
  }

  @override
  Future<Uint8List?> getHealthData() {
    return Future.value(Uint8List(16));
  }

  @override
  Future<Uint8List?> getHealthOpen() {
    return Future.value(Uint8List(16));
  }

  @override
  Future<Uint8List?> getHeartRateControl() {
    return Future.value(Uint8List(16));
  }

  @override
  Future<Uint8List?> setHeartRateControl(Map<String, dynamic> param) {
    return Future.value(Uint8List(16));
  }

  @override
  Future<Uint8List?> getBloodOxygenHistory(Map<String, dynamic> param) {
    return Future.value(Uint8List(16));
  }

  @override
  Future<Uint8List?> getBloodPressureHistory(Map<String, dynamic> param) {
    return Future.value(Uint8List(16));
  }

  @override
  Future<Uint8List?> getBloodSugarHistory(Map<String, dynamic> param) {
    return Future.value(Uint8List(16));
  }

  @override
  Future<Uint8List?> getHeartRateHistory(Map<String, dynamic> param) {
    return Future.value(Uint8List(16));
  }

  @override
  Future<Uint8List?> getMaiHistory(Map<String, dynamic> param) {
    return Future.value(Uint8List(16));
  }

  @override
  Future<Uint8List?> getMetHistory(Map<String, dynamic> param) {
    return Future.value(Uint8List(16));
  }

  @override
  Future<Uint8List?> getPressureHistory(Map<String, dynamic> param) {
    return Future.value(Uint8List(16));
  }

  @override
  Future<Uint8List?> getSportHistory() {
    return Future.value(Uint8List(16));
  }

  @override
  Future<Uint8List?> getStepHistory(Map<String, dynamic> param) {
    return Future.value(Uint8List(16));
  }

  @override
  Future<Uint8List?> getSleepHistory(Map<String, dynamic> param) {
    return Future.value(Uint8List(16));
  }

  @override
  Future<Uint8List?> getTempHistory(Map<String, dynamic> param) {
    return Future.value(Uint8List(16));
  }

  @override
  Future<Uint8List?> getValidHistoryDates(Map<String, dynamic> param) {
    return Future.value(Uint8List(16));
  }

  @override
  Future<Uint8List?> setHealthOpen(Map<String, dynamic> param) {
    // TODO: implement setHealthOpen
    throw UnimplementedError();
  }
}

void main() {
  final SaveUsStarmaxPlatform initialPlatform = SaveUsStarmaxPlatform.instance;

  test('$MethodChannelSaveUsStarmax is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSaveUsStarmax>());
  });

  test('getPlatformVersion', () async {
    SaveUsStarmax saveUsStarmaxPlugin = SaveUsStarmax();
    MockSaveUsStarmaxPlatform fakePlatform = MockSaveUsStarmaxPlatform();
    SaveUsStarmaxPlatform.instance = fakePlatform;

    expect(await saveUsStarmaxPlugin.getPlatformVersion(), '42');
  });
}
