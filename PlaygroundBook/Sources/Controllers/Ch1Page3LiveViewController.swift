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

@objc(Ch1Page3LiveViewController)
public class Ch1Page3LiveViewController: Ch1Page1LiveViewController {
    
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
