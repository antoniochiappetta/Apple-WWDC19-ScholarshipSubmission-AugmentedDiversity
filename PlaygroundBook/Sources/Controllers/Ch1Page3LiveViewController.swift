import UIKit
import PlaygroundSupport
import SpriteKit

@objc(Ch1Page3LiveViewController)
public class Ch1Page3LiveViewController: Ch1Page1LiveViewController {
    
    // MARK: - Setup
    
    public override func setupScene() {
        dishView.alpha = 0.0
        placeView.alpha = 0.0
        skillView.alpha = 0.0
        dishView.image = character.dishImage
        placeView.image = character.placeImage
        skillView.image = character.skillImage
        let scene = SKScene(size: CGSize(width: characterView.frame.size.width, height: characterView.frame.size.height))
        characterView.backgroundColor = .clear
        scene.backgroundColor = .clear
        characterView.presentScene(scene)
        let charSize = CGSize(width: 240, height: 244)
        let node = SKSpriteNode(texture: character.skinTexture, size: charSize)
        let clothesNode = SKSpriteNode(texture: character.clothesTexture, size: charSize)
        let hairNode = SKSpriteNode(texture: character.hairTexture, size: charSize)
        node.addChild(clothesNode)
        node.addChild(hairNode)
        let textures: [SKTexture] = character.skinTextures
        let animation = SKAction.animate(with: textures, timePerFrame: 0.3, resize: false, restore: false)
        node.run(SKAction.repeatForever(animation))
        let menu = GameMenuNode(element: node)
        _ = menu.wrap(node: node, dishAction: {
            self.say(message: self.character.dish.rawValue)
            menu.run(SKAction.move(to: CGPoint(x: scene.frame.maxX - 20 - node.frame.width/2, y: scene.frame.midY), duration: 5, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.5))
            UIView.animate(withDuration: 2, animations: {
                self.dishView.alpha = 1.0
            }, completion: { (completed) in
                self.showCompletion()
            })
        }, placeAction: {
            self.say(message: self.character.place.rawValue)
            menu.run(SKAction.move(to: CGPoint(x: scene.frame.midX, y: scene.frame.minY + 40 + node.frame.height/2), duration: 5, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.5))
            UIView.animate(withDuration: 2, animations: {
                self.placeView.alpha = 1.0
            }, completion: { (completed) in
                self.showCompletion()
            })
        }) {
            self.say(message: self.character.skill.rawValue)
            menu.run(SKAction.move(to: CGPoint(x: scene.frame.minX + node.frame.width/2, y: scene.frame.minY + 40 + node.frame.height/2), duration: 5, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.5))
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
        
        view.gestureRecognizers?.removeAll()
        characterView.isUserInteractionEnabled = true
        
        switch message {
        case .dictionary(let characterValues):
            characterValues.forEach({
                switch $0.key {
                case "dish":
                    if case .string(let dish) = $0.value {
                        character.dish = Dish(rawValue: dish)!
                    }
                    break
                case "place":
                    if case .string(let place) = $0.value {
                        character.place = Place(rawValue: place)!
                    }
                    break
                case "skill":
                    if case .string(let skill) = $0.value {
                        character.skill = Skill(rawValue: skill)!
                    }
                    break
                case "clothes":
                    if case .string(let clothes) = $0.value {
                        character.clothes = Clothes(rawValue: clothes)!
                    }
                    break
                case "skin":
                    if case .string(let skin) = $0.value {
                        character.skin = Skin(rawValue: skin)!
                    }
                    break
                case "hair":
                    if case .string(let hair) = $0.value {
                        character.hair = Hair(rawValue: hair)!
                    }
                    break
                default:
                    break
                }
            })
            self.setupScene()
            break
        default:
            break
        }
        
    }
}
