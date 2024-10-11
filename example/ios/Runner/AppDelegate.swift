import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)

        // 확인 로그 추가
        print("예제코드 : AppDelegate didFinishLaunchingWithOptions called")

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
