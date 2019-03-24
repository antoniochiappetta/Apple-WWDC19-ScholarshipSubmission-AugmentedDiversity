//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//
//#-end-hidden-code

/*:
 # What can you find around you?
 
 Many people are convinced that what is different from them is not always good. But they often don't know what they are missing about other people.
 That's why I want you to explore to world around you to find out something about other amazing countries.
 
 But first, you need to choose which country to discover.
 - Example:
 This example shows how to use the `discover` method with the name of a country to add it to the scene.\
 \
 `discover(country: .Mexico)`
 
 - - -
 1. Choose countries to *discover* and tap on *Run My Code*
 2. Move around until a plane is detected, you will see a sphere appear for each of the countries you chose.
 3. Each sphere has a flag on top of it, try to move closer to enter one of the them.
 4. Look inside the box, here you find a new triple of *skill*, *place* and *dish* typical of this particular country. See how many incredible things the world has to offer you?
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
                page.assessmentStatus = .pass(message: "### Perfect! \nYou can go inside the spheres to see that also people different from you have something special you can learn from, now go \"build\" your own persona! \n\n[**Next page**](@next)")
            }
        default:
            break
        }
    }
    
}


let listener = LiveViewListener()
proxy?.delegate = listener

var chosenCountries: [PlaygroundValue] = []

func discover(country: Country) {
    chosenCountries.append(.string(country.rawValue))
}

func showCountries(countries: [PlaygroundValue]) {
    if let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy {
        proxy.send(.array(countries))
    }
}

//#-end-hidden-code
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, discover(country:), ., China, Egypt, Mexico)
//#-editable-code Discover

//#-end-editable-code
//#-hidden-code
showCountries(countries: chosenCountries)
//#-end-hidden-code


