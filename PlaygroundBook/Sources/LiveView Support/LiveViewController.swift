import UIKit
import PlaygroundSupport

@objc(Book_Sources_LiveViewController)
open class LiveViewController: UIViewController, PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer {

    open func receive(_ message: PlaygroundValue) {
        // Not implemented
    }
}
