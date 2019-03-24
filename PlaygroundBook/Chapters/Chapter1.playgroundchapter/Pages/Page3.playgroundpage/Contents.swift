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
 
 Can a Chinese man have mustaches? Can an Egyptian man have pink skin? The ease of traveling in our age has generated incredible mixes and each one of us should be able to appreciate even what is non-conventional.
 
 That's why now it's *mix time*! You will create your own persona mixing physical and cultural characteristics of the men and countries you met before. It will be your idea of [global citizen](glossary://GlobalCitizen)!
 
 ![GlobalCitizenship](global_citizenship.png)
 
 - - -
 1. You still see is still me, Antonio, the Italian man. Try redefining the properties of the character to build your *persona* and tap on *Run My Code*.
 2. Try to long press on your persona and choose the right action to call all the other friends we met so far to join our amazing *multicultural environment*.
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
                page.assessmentStatus = .pass(message: "### Fantastic! \nYou are truly part of a multicultural world now! Go and spread the world about the importance of human diversity with everyone!")
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
//#-code-completion(identifier, show, select(dish:), Dish, ., Ramen, The, Pizza, Tacos)
//#-code-completion(identifier, show, select(place:), Place, ., ChineseWall, Pyramids, Colosseum, MayaTemple)
//#-code-completion(identifier, show, select(skill:), Skill, ., MartialArts, Hieroglyphs, Football, Corrida)
//#-code-completion(identifier, show, change(clothes:), Clothes, ., China, Egypt, Italy, Mexico)
//#-code-completion(identifier, show, change(skin:), Skin, ., China, Egypt, Italy, Mexico)
//#-code-completion(identifier, show, change(hair:), Hair, ., China, Egypt, Italy, Mexico)
//#-editable-code Build persona

//#-end-editable-code
//#-hidden-code
showCharacter(character: characterValues)
//#-end-hidden-code


