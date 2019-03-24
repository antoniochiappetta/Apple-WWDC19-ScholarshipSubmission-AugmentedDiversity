//
//  GameMenuNode.swift
//  GameTapMenu
//
//  Created by Riccardo Sabbatini on 03/05/2017.
//  Copyright © 2017 Riccardo Sabbatini. All rights reserved.
//

import SpriteKit

open class GameMenuNode: SKNode {
    
    // MARK: - Nested types
    
    enum MenuPhase: Int {
        case resting
        case unfolding
        case unfolded
        case folding
    }
    
    // MARK: - Properties
    
    override open var frame: CGRect {
        get {
            return bodyNode.frame
        }
    }
    
    private var phase: MenuPhase = .resting
    private var hilightedIndex: Int = -1
    
    var actions: [GameAction] = [] {
        didSet {
            setupSubnodes()
        }
    }
    
    var subNodes: [SKShapeNode] = []
    weak var bodyNode: SKNode!
    var touches: [UITouch: Date] = [:]
    
    var actionDistance: CGFloat = 150
    var actionIconRadius: CGFloat = 20
    
    var minPadding: CGFloat = 50
    
    var autoAngle: Bool = false
    
    var disableHighlighting: Bool = false
    
    private var _startAngle: CGFloat = .pi * 0.16
    var startAngle: CGFloat {
        get {
            if autoAngle, let scn = self.scene {
                let refNode = scn.camera ?? scn
                
                let xPos = self.position.x - refNode.position.x
                let yPos = self.position.y - refNode.position.y
                
                let maxX = scn.frame.width / 2
                let minX = -maxX
                let maxY = scn.frame.height / 2
                
                var defaultPosition = true
                
                let maxDistTop = self.actionDistance + self.actionIconRadius*2 + self.minPadding
                let maxDistSide = maxDistTop / CGFloat(sqrtf(2))
                if maxY - yPos < maxDistTop {
                    defaultPosition = false
                }
                else if abs(minX - xPos) < maxDistSide {
                    defaultPosition = false
                }
                else if maxX - xPos < maxDistSide {
                    defaultPosition = false
                }
                
                if defaultPosition {
                    return (.pi - arcAngle) / 2
                }
                else {
                    let angle: CGFloat = (.pi + atan2(yPos, xPos)).truncatingRemainder(dividingBy: .pi*2)
                    let snapAngle: CGFloat = .pi * (round((angle / (.pi*2)) * 8) / 4)
                    return snapAngle - (arcAngle / 2)
                }
            }
            else {
                return _startAngle
            }
        }
        set {
            _startAngle = newValue
        }
    }
    var arcAngle: CGFloat = .pi * 0.66
    
    // MARK: - Lifecycle
    
    public init(element: SKNode) {

        bodyNode = element
        super.init()
        self.isUserInteractionEnabled = true
        bodyNode.zPosition = 0
        bodyNode.position = .zero
        addChild(bodyNode)
        
        setupSubnodes()
        
    }
    
    deinit {
        actions.removeAll()
        subNodes.removeAll()
        touches.removeAll()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Methods
    
    func getAngle(forIndex index: Int) -> CGFloat {
        let segmentsNum = self.arcAngle.truncatingRemainder(dividingBy: CGFloat.pi*2) == 0 ? subNodes.count : subNodes.count - 1
        let angleDelta: CGFloat = self.arcAngle / CGFloat(segmentsNum)
        let start = (startAngle + .pi*2).truncatingRemainder(dividingBy: .pi*2)
        
        var idx = index
        if start >= .pi / 2 && start < 3 * .pi / 4 {
            idx = subNodes.count - 1 - index
        }
        
        return start + angleDelta * CGFloat(idx)
    }
    
    /**
    *  Create the actions menu for the given item (and its corresponding node). The node is firstly removed from the parent, then it becomes a child of the menu and menu is added to the parent node at the same position of the node 
    */ 
    public func wrap(node: SKNode, dishAction: @escaping ()-> Void, placeAction: @escaping ()->Void, skillAction: @escaping ()->Void) -> GameMenuNode {
        
        let _zPosition = node.zPosition //store these properties
        let _position = node.position
        let parentNode = node.parent
        
        node.removeFromParent()
        let menu = GameMenuNode(element: node)
        menu.position = _position
        menu.zPosition = _zPosition
     
        node.position = .zero
        parentNode?.addChild(menu)
        
        menu.actions = [
            GameAction(icon: SKTexture(imageNamed: "dishAction"), code: {
                dishAction()
            }),
            GameAction(icon: SKTexture(imageNamed: "placeAction"), code: {
                placeAction()
            }),
            GameAction(icon: SKTexture(imageNamed: "skillAction"), code: {
                skillAction()
            })
        ]
        
        return menu
        
    }
    
    static func unwrap(node menu: GameMenuNode) -> (SKNode)? {
        
        if let node = menu.bodyNode {
            node.removeFromParent()
            menu.removeFromParent()
            return node
        }
        return nil
    }
    
    func setupSubnodes() {
        
        subNodes.forEach {
            $0.removeFromParent()
        }
        
        subNodes = actions.map {
            // TODO check how to do this stuff
            let node = SKShapeNode(circleOfRadius: self.actionIconRadius)
            node.fillColor = UIColor.darkGray.withAlphaComponent(0.8)
            node.alpha = 0
            node.zRotation = CGFloat.pi
            node.zPosition = .greatestFiniteMagnitude
            node.lineWidth = 8
            node.strokeColor = UIColor.white.withAlphaComponent(0.3)
            let icnInteraction = SKSpriteNode(texture: $0.icon)
            icnInteraction.size = CGSize(width: 85, height: 85)
            node.addChild(icnInteraction)
            return node
        }
        
        subNodes.forEach { self.addChild($0) }
    }
    
    // MARK: - Touches handling
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        parent?.touchesBegan(touches, with: event)
        for t in touches.filter({ self.bodyNode.contains($0.location(in: self)) }) {
            self.touches[t] = Date()
        }
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        parent?.touchesMoved(touches, with: event)
        for t in touches.filter({ self.touches[$0]?.timeIntervalSinceNow ?? 0 < -0.15 }) {
            switch phase {
            case .resting:
                phase = .unfolding
                
                let unfoldDuration: TimeInterval = 0.8
                
                subNodes.enumerated().forEach({ (offset, element) in
                    let currentAnglePosition = getAngle(forIndex: offset)
                    let destPoint: CGPoint = CGPoint(x: cos(currentAnglePosition) * actionDistance, y: sin(currentAnglePosition) * actionDistance)
                    
                    var groupActions: [SKAction] = [
                        SKAction.move(to: destPoint, duration: unfoldDuration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.2),
                        SKAction.rotate(toAngle: CGFloat.pi*2, duration: unfoldDuration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.2),
                        SKAction.fadeAlpha(to: 1.0, duration: unfoldDuration/8)
                    ]
                    
                    if offset == 0 {
                        disableHighlighting = true
                        groupActions.append(SKAction.sequence([
                            SKAction.wait(forDuration: unfoldDuration * 0.6),
                            SKAction.run { [weak self] in
                                self?.disableHighlighting = false
                            }
                            ]))
                    }
                    
                    let unfoldAction = SKAction.group(groupActions)
                    
                    element.run(offset == 0 ? SKAction.sequence([unfoldAction, SKAction.run {
                        [weak self] in
                        self?.phase = .unfolded
                        } ]) : unfoldAction, withKey: "unfold")
                    
                })
                
            case .unfolding, .unfolded:
                
                if disableHighlighting {
                    break
                }
                
                if let (idx, node) = subNodes.enumerated().first(where: { (_, element) -> Bool in
                    return element.contains(t.location(in: self)) }) {
                    if self.hilightedIndex != idx {
                        let oldIdx = self.hilightedIndex
                        self.hilightedIndex = idx
                        
                        let currentAnglePos = getAngle(forIndex: idx)
                        node.run(SKAction.group([
                            SKAction.scale(to: 1.5, duration: 0.3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.2),
                            SKAction.move(to: CGPoint(x: cos(currentAnglePos) * (actionDistance + actionIconRadius*0.5), y: sin(currentAnglePos) * (actionDistance + actionIconRadius*0.5)), duration: 0.3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.2)
                            ]))
                        
                        if oldIdx != -1 {
                            let oldNode = self.subNodes[oldIdx]
                            
                            let oldNodeAnglePos = getAngle(forIndex: oldIdx)
                            
                            oldNode.run(SKAction.group([
                                SKAction.scale(to: 1.0, duration: 0.3),
                                SKAction.move(to: CGPoint(x: cos(oldNodeAnglePos) * actionDistance, y: sin(oldNodeAnglePos) * actionDistance), duration: 0.3)
                                ]))
                        }
                        
                    }
                }
                else if (self.hilightedIndex != -1) {
                    
                    let node = self.subNodes[hilightedIndex]
                    
                    let oldNodeAnglePos = getAngle(forIndex: hilightedIndex)
                    
                    node.run(SKAction.group([
                        SKAction.scale(to: 1.0, duration: 0.3),
                        SKAction.move(to: CGPoint(x: cos(oldNodeAnglePos) * actionDistance, y: sin(oldNodeAnglePos) * actionDistance), duration: 0.3)
                        ]))
                    self.hilightedIndex = -1
                }
                
            default:
                break
                
            }
        }
    }
    
    func touchesUp(_ touches: Set<UITouch>, with event: UIEvent?) {
        touches.forEach { self.touches.removeValue(forKey: $0) }
        
        switch phase {
        case .unfolding:
            subNodes.forEach {
                $0.removeAction(forKey: "unfold")
            }
            fallthrough
        case .unfolded:
            phase = .folding
            let foldDuration: TimeInterval = 0.8
            subNodes.enumerated().forEach({ (offset, element) in
                var actions: [SKAction] = []
                
                if offset == self.hilightedIndex {
                    actions.append(SKAction.scale(to: 2.0, duration: foldDuration))
                    self.actions[self.hilightedIndex].execBlock?()
                }
                else {
                    actions.append(contentsOf: [SKAction.move(to: CGPoint.zero, duration: foldDuration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.2),
                                                SKAction.rotate(toAngle: CGFloat.pi, duration: foldDuration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.2)])
                }
                
                // TODO maybe add a "blink" when the action is executed
                
                let fade = SKAction.fadeAlpha(to: 0.0, duration: foldDuration/2.5)
                fade.timingMode = .easeIn
                actions.append(fade)
                
                let foldAction = SKAction.sequence([
                    SKAction.group(actions),
                    SKAction.run {
                        element.position = CGPoint.zero
                        element.xScale = 1.0
                        element.yScale = 1.0
                    }])
                
                element.run(offset == 0 ? SKAction.sequence([foldAction, SKAction.run {
                    [weak self] in
                    self?.phase = .resting
                    } ]) : foldAction, withKey: "fold")
            })
            
            if hilightedIndex == -1 {
            }
            else {
                self.hilightedIndex = -1
            }
            
        default:
            print("default")
        }
        
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        parent?.touchesEnded(touches, with: event)
        touchesUp(touches, with: event)
    }
    
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        parent?.touchesCancelled(touches, with: event)
        touchesUp(touches, with: event)
        
    }
    
}
