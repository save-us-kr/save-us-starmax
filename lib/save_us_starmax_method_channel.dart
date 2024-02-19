import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'save_us_starmax_platform_interface.dart';

/// An implementation of [SaveUsStarmaxPlatform] that uses method channels.
class MethodChannelSaveUsStarmax extends SaveUsStarmaxPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('save_us_starmax');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
