import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    let infoDictionary = Bundle.main.infoDictionary!
    let flavor:String = infoDictionary["Flavor"] as! String? ?? ""
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController;
    let flavorChannel = FlutterMethodChannel.init(name: "flavor", binaryMessenger: controller);
    flavorChannel.setMethodCallHandler({(call: FlutterMethodCall, result: FlutterResult) -> Void in
        if ("getFlavor" == call.method) {
            result(flavor);
        }
    });

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
