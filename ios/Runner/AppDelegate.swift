import UIKit
import Flutter
import FirebaseCore
import flutter_local_notifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
  FirebaseApp.configure()
  FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
       GeneratedPluginRegistrant.register(with: registry)

  }
//
//     SwiftFlutterBackgroundServicePlugin.taskIdentifier = "com.taskitly.app"

  if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate

//       let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//       UNUserNotificationCenter.current().requestAuthorization(
//         options: authOptions,
//         completionHandler: { _, _ in }
//       )
//
//       application.registerForRemoteNotifications()

  }
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
