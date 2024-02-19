
import 'save_us_starmax_platform_interface.dart';

class SaveUsStarmax {
  Future<String?> getPlatformVersion() {
    return SaveUsStarmaxPlatform.instance.getPlatformVersion();
  }
}
