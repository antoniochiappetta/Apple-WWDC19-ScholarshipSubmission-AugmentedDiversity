import UIKit
import PlaygroundSupport

open class StatusLiveViewController: LiveViewController {
    
    // MARK: - Properties
    
    public var isCompleted = false
    
    lazy public var statusViewController: StatusViewController = {
        return self.children.first! as! StatusViewController
    }()
    
    // MARK: - ViewController Lifecycle
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.green.withAlphaComponent(0.3)
        
        let warningTap = UITapGestureRecognizer(target: self, action: #selector(sayWarning))
        view.addGestureRecognizer(warningTap)
    }
    
    // MARK: - Actions
    
    public func showCompletion() {
        if !isCompleted {
            let message: PlaygroundValue = .boolean(true)
            self.send(message)
        }
        isCompleted = true
    }
    
    @objc public func sayWarning() {
        // Not implemented
    }
    
    @objc public func sayWellDone() {
        self.statusViewController.show(message: "Well done")
    }
    
    @objc public func say(message: String) {
        self.statusViewController.show(message: message)
    }
    
}
