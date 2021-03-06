//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//
//#-end-hidden-code
/*:
 # Build your persona!
 
 Can a Chinese man have mustaches? Can an Egyptian man have pink skin? The ease of traveling in our age has generated incredible mixes and each one of us should be able to appreciate even what is *non-conventional*.
 
 That's why now it's **mix time**! You will create your own persona mixing physical and cultural characteristics of the men and countries you met before. It will be your idea of [global citizen](glossary://GlobalCitizen)!
 
 ![GlobalCitizenship](global_citizenship.png)
 
 - - -
 1. You still see is still me, Antonio, the Italian man. Try redefining the properties of the character to build your *persona* and tap on *Run My Code*.
 2. Long press on your persona to enjoy the mix of physical and cultural characteristics you just created.
 */
//#-code-completion(everything, hide)
//#-hidden-code

import PlaygroundSupport

let page = PlaygroundPage.current
page.needsIndefiniteExecution = true
let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy

class LiveViewListener: PlaygroundRemoteLiveViewProxyDelegate {
    
    func remoteLiveViewProxyConnectionClosed(_ remoteLiveViewProxy: PlaygroundRemoteLiveViewProxy) {
        PlaygroundPage.current.finishExecution()
    }
    
    func remoteLiveViewProxy(_ remoteLiveViewProxy: PlaygroundRemoteLiveViewProxy, received value: PlaygroundValue) {
        switch value {
        case let .boolean(animated):
            if animated == true {
                page.assessmentStatus = .pass(message: "### Fantastic! \nYou are truly part of a **multicultural world** now! Go and spread the word about the importance of human diversity with everyone!")
            }
        default:
            break
        }
    }
    
}


let listener = LiveViewListener()
proxy?.delegate = listener

var characterValues: [String:PlaygroundValue] = [:]

func select(dish: Dish) {
    characterValues["dish"] = .string(dish.rawValue)
}

func select(place: Place) {
    characterValues["place"] = .string(place.rawValue)
}

func select(skill: Skill) {
    characterValues["skill"] = .string(skill.rawValue)
}

func change(clothes: Clothes) {
    characterValues["clothes"] = .string(clothes.rawValue)
}

func change(skin: Skin) {
    characterValues["skin"] = .string(skin.rawValue)
}

func change(hair: Hair) {
    characterValues["hair"] = .string(hair.rawValue)
}

func showCharacter(character: [String:PlaygroundValue]) {
    if let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy {
        proxy.send(.dictionary(character))
    }
}

//#-end-hidden-code
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, select(dish:), ., Gyoza, KushariTea, Pizza, Tacos)
//#-code-completion(identifier, show, select(place:), ., ChineseWall, Pyramids, Colosseum, MayaTemples)
//#-code-completion(identifier, show, select(skill:), ., MartialArts, Camels, Football, Corrida)
//#-code-completion(identifier, show, change(clothes:), ., China, Egypt, Italy, Mexico)
//#-code-completion(identifier, show, change(skin:), ., China, Egypt, Italy, Mexico)
//#-code-completion(identifier, show, change(hair:), ., China, Egypt, Italy, Mexico)
//#-editable-code Build persona

//#-end-editable-code
//#-hidden-code
showCharacter(character: characterValues)
//#-end-hidden-code


