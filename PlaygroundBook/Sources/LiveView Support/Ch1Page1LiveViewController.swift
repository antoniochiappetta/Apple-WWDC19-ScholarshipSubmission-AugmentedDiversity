//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  An auxiliary source file which is part of the book-level auxiliary sources.
//  Provides the implementation of the "always-on" live view.
//

import UIKit
import PlaygroundSupport
import SpriteKit

@objc(Ch1Page1LiveViewController)
public class Ch1Page1LiveViewController: StatusLiveViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var characterView: SKView!
    @IBOutlet private weak var dishView: UIView!
    @IBOutlet private weak var placeView: UIView!
    @IBOutlet private weak var skillView: UIView!
    
    // MARK: - Properties
    
    private var isCompleted = false
    
    // MARK: - ViewController Lifecycle
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setupScene()
    }
    
    // MARK: - Actions
    
    private func showCompletion() {
        if !isCompleted {
            let message: PlaygroundValue = .boolean(true)
            self.send(message)
        }
        isCompleted = true
    }
    
    public func setupScene() {
        characterView.isUserInteractionEnabled = false
        let scene = SKScene(size: CGSize(width: characterView.bounds.size.width, height: characterView.bounds.size.height))
        characterView.backgroundColor = .clear
        scene.backgroundColor = .clear
        characterView.presentScene(scene)
        let node = SKSpriteNode(texture: SKTexture(imageNamed: "ItalianCharacter.png"), color: .clear, size: CGSize(width: 240, height: 225))
        let menu = GameMenuNode(element: node)
        _ = menu.wrap(node: node, dishAction: {
            self.say(message: "Pasta!")
            menu.run(SKAction.move(to: CGPoint(x: scene.frame.midX + 200, y: scene.frame.midY), duration: 5, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.5))
            UIView.animate(withDuration: 2, animations: {
                self.dishView.alpha = 1.0
            }, completion: { (completed) in
                self.showCompletion()
            })
        }, placeAction: {
            self.say(message: "Rome's Colosseum!")
            menu.run(SKAction.move(to: CGPoint(x: scene.frame.midX, y: scene.frame.midY - 300), duration: 5, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.5))
            UIView.animate(withDuration: 2, animations: {
                self.placeView.alpha = 1.0
            }, completion: { (completed) in
                self.showCompletion()
            })
        }) {
            self.say(message: "Football!")
            menu.run(SKAction.move(to: CGPoint(x: scene.frame.midX - 200, y: scene.frame.midY), duration: 5, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.5))
            UIView.animate(withDuration: 2, animations: {
                self.skillView.alpha = 1.0
            }, completion: { (completed) in
                self.showCompletion()
            })
        }
        scene.addChild(menu)
        menu.position = CGPoint(x: scene.frame.midX, y: scene.frame.midY)
    }

    // MARK: - PlaygroundLiveViewMessageHandler
    
    public override func receive(_ message: PlaygroundValue) {
        
        switch message {
        default:
            characterView.isUserInteractionEnabled = true
            view.gestureRecognizers?.removeAll()
            break
        }
        
    }
}
