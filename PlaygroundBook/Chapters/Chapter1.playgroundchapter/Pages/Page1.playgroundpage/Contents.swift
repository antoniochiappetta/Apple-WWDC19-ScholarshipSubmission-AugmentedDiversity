//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//
//#-end-hidden-code
/*:
 # Hi man!
 
 My name is Antonio and I'm gonna tell you something about [human diversity](glossary://Human diversity).
 Many people don't appreciate who is different from them, they don't like people with a different skin color or coming from a different country. But everyone has something special to offer!
 
 Look at me! I'm italian and I have very special things to offer you!
 
 ![Italy](ItalianFlag.png)
 
 - - -
 1. First of all, to enable the interactions with me and *start learning*, tap on *Run My Code*.
 2. Then try to long press on me and see what I can show you: I chose a *skill*, a *place* and a *dish* that are typical of my country.
 3. Every time you choose an option, you will understand once more why you should visit Italy!
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
                page.assessmentStatus = .pass(message: "### Perfect! \nYou learnt what Italians have to offer you, go ahead and discover more about other people! \n\n[**Next page**](@next)")
            }
        default:
            break
        }
    }
    
}


let listener = LiveViewListener()
proxy?.delegate = listener

func startLearning() {
    if let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy {
        proxy.send(.boolean(true))
    }
}

//#-end-hidden-code
startLearning()
//#-end-editable-code


