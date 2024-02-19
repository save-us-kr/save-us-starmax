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
}
