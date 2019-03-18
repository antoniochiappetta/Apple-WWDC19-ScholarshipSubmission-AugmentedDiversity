//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  Provides supporting functions for setting up a live view.
//

import UIKit
import PlaygroundSupport

/// Instantiates a new instance of a live view.
///
/// By default, this loads an instance of `LiveViewController` from `LiveView.storyboard`.
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

/// List of available live views
public enum LiveViewID: String {
    case ChapterOnePageOne, ChapterOnePageTwo, ChapterOnePageThree, ChapterTwoPageOne
}

/// Instantiates a new instance of a live view by storboardID
///
/// This load an instance of 'LiveViewController' from 'LiveView.storyboard' having the specified storyboardID
public func instantiateLiveView(storyboardID: LiveViewID) -> PlaygroundLiveViewable {
    let storyboard = UIStoryboard(name: "LiveView", bundle: nil)
    
    let viewController = storyboard.instantiateViewController(withIdentifier: storyboardID.rawValue)
    
    guard let liveViewController = viewController as? LiveViewController else {
        fatalError("LiveView.storyboard's initial scene is not a LiveViewController; please either update the storyboard or this function")
    }
    
    return liveViewController
}

