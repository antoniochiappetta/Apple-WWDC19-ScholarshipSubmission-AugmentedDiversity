import UIKit
import PlaygroundSupport

public func instantiateLiveView() -> PlaygroundLiveViewable {
    
    let storyboard = UIStoryboard(name: "LiveView", bundle: nil)

    guard let viewController = storyboard.instantiateInitialViewController() else {
        fatalError("LiveView.storyboard does not have an initial scene; please set one or update this function")
    }

    guard let liveViewController = viewController as? LiveViewController else {
        fatalError("LiveView.storyboard's initial scene is not a LiveViewController; please either update the storyboard or this function")
    }

    return liveViewController
}

public enum LiveViewID: String {
    case ChapterOnePageOne, ChapterOnePageTwo, ChapterOnePageThree, ChapterTwoPageOne
}

public func instantiateLiveView(storyboardID: LiveViewID) -> PlaygroundLiveViewable {
    let storyboard = UIStoryboard(name: "LiveView", bundle: nil)
    
    let viewController = storyboard.instantiateViewController(withIdentifier: storyboardID.rawValue)
    
    guard let liveViewController = viewController as? LiveViewController else {
        fatalError("LiveView.storyboard's initial scene is not a LiveViewController; please either update the storyboard or this function")
    }
    
    return liveViewController
}

