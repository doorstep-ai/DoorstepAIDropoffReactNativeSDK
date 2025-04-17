import SwiftUI
import DoorstepDropoffSDK

@objc(RootDoorstepAIViewManager)
class RootDoorstepAIViewManager: RCTViewManager {
    override func view() -> UIView! {
        let hostingController = UIHostingController(rootView: DoorstepAIRoot())
        return hostingController.view
    }

    override static func requiresMainQueueSetup() -> Bool {
    return true
  }
        
}
