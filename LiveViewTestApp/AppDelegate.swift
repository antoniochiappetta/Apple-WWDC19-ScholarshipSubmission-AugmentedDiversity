import UIKit
import PlaygroundSupport
import LiveViewHost
import Book_Sources

@UIApplicationMain
class AppDelegate: LiveViewHost.AppDelegate {
    override func setUpLiveView() -> PlaygroundLiveViewable {
        return Book_Sources.instantiateLiveView()
    }

    override var liveViewConfiguration: LiveViewConfiguration {
        return .fullScreen
    }
}
