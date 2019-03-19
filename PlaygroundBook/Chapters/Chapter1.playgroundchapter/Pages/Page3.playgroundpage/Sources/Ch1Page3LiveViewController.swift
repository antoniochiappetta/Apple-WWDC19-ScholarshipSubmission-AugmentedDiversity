//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  An auxiliary source file which is part of the book-level auxiliary sources.
//  Provides the implementation of the "always-on" live view.
//

import UIKit
import PlaygroundSupport

@objc(Ch1Page1LiveViewController)
public class Ch1Page3LiveViewController: LiveViewController {
    
    // MARK: - Properties
    
    lazy var statusViewController: StatusViewController = {
        return self.children.first! as! StatusViewController
    }()
    
    // MARK: - Actions
    
    @objc public func remindUser() {
        self.statusViewController.show(message: "Run My Code to start learning")
    }
    
    @objc public func generateMenu() {
        self.statusViewController.show(message: "Well done")
        let message: PlaygroundValue = .boolean(true)
        self.send(message)
    }

    // MARK: - PlaygroundLiveViewMessageHandler
    
    public override func receive(_ message: PlaygroundValue) {
        
        switch message {
        default:
            let previousTap = UITapGestureRecognizer(target: self, action: #selector(remindUser))
            view.removeGestureRecognizer(previousTap)
            // Block long press interaction before user taps on run my code
            let longPress = UILongPressGestureRecognizer(target: self, action: #selector(generateMenu))
            view.addGestureRecognizer(longPress)
            break
        }
        
    }
}
