//
//  GameAction.swift
//  InsegnoALucioLeCose
//
//  Created by Riccardo Sabbatini on 10/05/2017.
//  Copyright © 2017 Riccardo Sabbatini. All rights reserved.
//

import SpriteKit

// A gameaction creates a correspondence between an icon or symbol and an asynchronous callback
class GameAction {
    
    // MARK: - Properties
    
    var icon: SKTexture?
    var symbol: String = ""
    var execBlock: (() -> Void)?
    
    // MARK: - initialization
    
    init(symbol: String, code: @escaping () -> Void) {
        self.symbol = symbol
        self.execBlock = code
    }
    
    init(icon: SKTexture, code: @escaping () -> Void) {
        self.icon = icon
        self.execBlock = code
    }
    
}
