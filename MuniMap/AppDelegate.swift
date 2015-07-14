import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        if (NSClassFromString("XCTest") != nil) {
            return false
        }
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let apiClient = ApiClient(URLSession: NSURLSession.sharedSession(), apiToken: "b4aed8bc-5bdb-455b-b905-c1208ff30e2e")
        let rootViewController = RootViewController(apiClient: apiClient)
        window?.rootViewController = UINavigationController(rootViewController: rootViewController)
        window?.makeKeyAndVisible()

        return true
    }
}

