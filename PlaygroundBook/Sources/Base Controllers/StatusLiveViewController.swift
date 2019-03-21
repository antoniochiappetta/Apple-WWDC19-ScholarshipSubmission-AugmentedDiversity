//
//  StatusLiveViewController.swift
//  Book_Sources
//
//  Created by Antonio Chiappetta on 20/03/2019.
//

import UIKit
import PlaygroundSupport

open class StatusLiveViewController: LiveViewController {
    
    // MARK: - Properties
    
    lazy open var statusViewController: StatusViewController = {
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
    
    @objc open func sayWarning() {
        self.statusViewController.show(message: "Run My Code to start learning")
    }
    
    @objc open func sayWellDone() {
        self.statusViewController.show(message: "Well done")
    }
    
    @objc open func say(message: String) {
        self.statusViewController.show(message: message)
    }
    
}
