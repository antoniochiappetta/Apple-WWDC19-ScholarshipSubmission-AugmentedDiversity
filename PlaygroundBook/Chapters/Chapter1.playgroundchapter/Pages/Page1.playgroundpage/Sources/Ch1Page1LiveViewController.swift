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
public class Ch1Page1LiveViewController: StatusLiveViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var characterView: UIView!
    @IBOutlet private weak var dishView: UIView!
    @IBOutlet private weak var placeView: UIView!
    @IBOutlet private weak var skillView: UIView!
    
    // MARK: - Properties
    
    private var isCompleted = false
    
    // MARK: - Actions
    
    @objc public func generateMenu() {
        if !isCompleted {
            sayWellDone()
            let message: PlaygroundValue = .boolean(true)
            self.send(message)
        }
        isCompleted = true
    }

    // MARK: - PlaygroundLiveViewMessageHandler
    
    public override func receive(_ message: PlaygroundValue) {
        
        switch message {
        default:
            view.gestureRecognizers?.removeAll()
            let longPress = UILongPressGestureRecognizer(target: self, action: #selector(generateMenu))
            characterView.addGestureRecognizer(longPress)
            break
        }
        
    }
}
