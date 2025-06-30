import UIKit
import OSLog

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let logger = Logger(subsystem: "com.christophebedard.lidar2ros", category: "AppDelegate")

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        logger.info("application did finish launching")
        return true
    }

    // These are still useful for app-level state tracking
    func applicationDidEnterBackground(_ application: UIApplication) {
        logger.debug("App entered background")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        logger.debug("App will enter foreground")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        logger.debug("App will terminate")
    }
}
