import SpriteKit

class GameAction {
    
    // MARK: - Properties
    
    var icon: SKTexture?
    var symbol: String = ""
    var execBlock: (() -> Void)?
    
    // MARK: - Initialization
    
    init(symbol: String, code: @escaping () -> Void) {
        self.symbol = symbol
        self.execBlock = code
    }
    
    init(icon: SKTexture, code: @escaping () -> Void) {
        self.icon = icon
        self.execBlock = code
    }
    
}
