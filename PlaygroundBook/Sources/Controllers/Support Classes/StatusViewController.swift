import UIKit

@objc(StatusViewController)
public class StatusViewController: UIViewController {
    
    // MARK: - ViewController Lifecycle
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        statusLabel.backgroundColor = .brown
        statusLabel.textColor = .white
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var statusLabel: UILabel! {
        didSet {
            // Set label style
            statusLabel.layer.cornerRadius = 15
            statusLabel.layer.masksToBounds = true
            // Hide initially
            statusLabel.isHidden = true
        }
    }
    
    // MARK: - Properties
    
    private var messageHideTimer: Timer?
    private var displayDuration = TimeInterval(5)
    
    // MARK: - Message Handling
    
    public func show(message: String) {
        messageHideTimer?.invalidate()
        self.statusLabel.text = message
        self.showOrHideMessage(hide: false)
        
        messageHideTimer = Timer.scheduledTimer(withTimeInterval: displayDuration, repeats: false, block: { [weak self] _ in
            self?.showOrHideMessage(hide: true)
        })
        
    }
    
    // MARK: - Private Implementation
    
    private func showOrHideMessage(hide: Bool) {
        self.statusLabel.isHidden = hide
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [.beginFromCurrentState], animations: {
            self.statusLabel.alpha = hide ? 0 : 1
        }, completion: nil)
    }
}
