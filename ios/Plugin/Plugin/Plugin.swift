import Foundation
import Capacitor
import Photos
import UIKit

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitor.ionicframework.com/docs/plugins/ios
 */
@objc(TwilioIosCapacitor)
public class TwilioIosCapacitor: CAPPlugin {

    @objc func joinTwilioRoom(_ call: CAPPluginCall) {

        guard let roomName = call.options["roomName"] as? String else {
            call.reject("Must provide an roomName")
            return
        }

        guard let accessToken = call.options["accessToken"] as? String else {
            call.reject("Must provide an accessToken")
            return
        }
        let podBundle = Bundle(for: TwilioVideoViewController.self)

        let bundleURL = podBundle.url(forResource: "Plugin", withExtension: "bundle")!
        let bundle = Bundle(url: bundleURL)!

        let viewController = TwilioVideoViewController(nibName: "TwilioVideoViewController", bundle: bundle)
        viewController.roomName = roomName
        viewController.accessToken = accessToken

        DispatchQueue.main.sync {
            //self.bridge.viewController.present(viewController, animated: true, completion: nil)
            viewController.view.backgroundColor = UIColor.white
            self.bridge.viewController.addChild(viewController)
            self.bridge.viewController.view.addSubview(viewController.view)
            self.bridge.viewController.view.sendSubviewToBack(viewController.view)
            //             self.bridge.viewController.view.superview?.bringSubviewToFront(self.bridge.viewController.view)
            self.bridge.viewController.view.isOpaque = false
            self.bridge.viewController.view.backgroundColor = UIColor.clear
        }

        call.resolve()
    }

}
