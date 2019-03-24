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
    @IBOutlet private weak var dishView: UIImageView!
    @IBOutlet private weak var placeView: UIImageView!
    @IBOutlet private weak var skillView: UIImageView!
    
    // MARK: - Properties
    
    private let character = Character(country: .Italy)
    
    // MARK: - ViewController Lifecycle
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setupScene()
    }
    
    // MARK: - Actions
    
    public func setupScene() {
        characterView.isUserInteractionEnabled = false
        let scene = SKScene(size: CGSize(width: characterView.bounds.size.width, height: characterView.bounds.size.height))
        characterView.backgroundColor = .clear
        scene.backgroundColor = .clear
        characterView.presentScene(scene)
        let node = SKSpriteNode(texture: character.characterTextures.first!, color: .clear, size: CGSize(width: 297, height: 302))
        let textures: [SKTexture] = character.characterTextures
        let animation = SKAction.animate(with: textures, timePerFrame: 0.3, resize: false, restore: false)
        node.run(SKAction.repeatForever(animation))
        let menu = GameMenuNode(element: node)
        _ = menu.wrap(node: node, dishAction: {
            self.say(message: self.character.dish.rawValue)
            menu.run(SKAction.move(to: CGPoint(x: scene.frame.midX + 250, y: scene.frame.midY), duration: 5, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.5))
            UIView.animate(withDuration: 2, animations: {
                self.dishView.alpha = 1.0
            }, completion: { (completed) in
                self.showCompletion()
            })
        }, placeAction: {
            self.say(message: self.character.place.rawValue)
            menu.run(SKAction.move(to: CGPoint(x: scene.frame.midX, y: scene.frame.midY - 300), duration: 5, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.5))
            UIView.animate(withDuration: 2, animations: {
                self.placeView.alpha = 1.0
            }, completion: { (completed) in
                self.showCompletion()
            })
        }) {
            self.say(message: self.character.skill.rawValue)
            menu.run(SKAction.move(to: CGPoint(x: scene.frame.midX - 250, y: scene.frame.midY - 300), duration: 5, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.5))
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
