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
 `discover(country: .USA)`
 
 - - -
 1. Move around until a plane is detected, you will see a box appear for each of the countries you chose.
 2. Each box has a flag on top of it, try to move closer to enter one of the box.
 3. Look inside the box, here you find a new triple of *place*, *dish* and *ability* typical of this particular country. See how many incredible things the world has to offer you?
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
                page.assessmentStatus = .pass(message: "### Perfect! \nYou learnt that also people different from you have something special you can learn from, now go \"build\" your own individual! \n\n[**Next page**](@next)")
            }
        default:
            break
        }
    }
    
}


let listener = LiveViewListener()
proxy?.delegate = listener

enum Country: String {
    case China, Egypt, Italy, USA
}

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
//#-code-completion(identifier, show, discover(country:), ., China, Egypt, USA)
//#-editable-code Send the right messages

//#-end-editable-code
//#-hidden-code
showCountries(countries: chosenCountries)
//#-end-hidden-code


