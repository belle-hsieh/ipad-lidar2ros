import UIKit
import ARKit
import OSLog

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let logger = Logger(subsystem: "com.christophebedard.lidar2ros", category: "SceneDelegate")
    private var pubManager: PubManager!

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }

        logger.info("Scene will connect")

        window = UIWindow(windowScene: windowScene)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if !ARWorldTrackingConfiguration.supportsFrameSemantics(.sceneDepth) {
            // Device doesn't support sceneDepth - show unsupported message VC
            guard let unsupportedVC = storyboard.instantiateViewController(withIdentifier: "unsupportedDeviceMessage") as? UIViewController else {
                fatalError("ViewController with identifier 'unsupportedDeviceMessage' not found")
            }
            window?.rootViewController = unsupportedVC
        } else {
            // Device supports sceneDepth - load main ViewController

            guard let mainVC = storyboard.instantiateInitialViewController() as? ViewController else {
                fatalError("Initial ViewController is not of type ViewController")
            }

            // Create pubManager and inject it before view loads
            self.pubManager = PubManager()

            mainVC.setPubManager(pubManager: self.pubManager)

            // Start pubManager after injection
            self.pubManager.start()

            window?.rootViewController = mainVC
        }

        window?.makeKeyAndVisible()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        logger.debug("Scene entered background")
        pubManager?.pubController.pause()
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        logger.debug("Scene will enter foreground")
        pubManager?.pubController.resume()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        logger.debug("Scene disconnected")
        pubManager?.pubController.disable()
    }
}
