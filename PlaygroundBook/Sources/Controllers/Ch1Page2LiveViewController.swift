//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  An auxiliary source file which is part of the book-level auxiliary sources.
//  Provides the implementation of the "always-on" live view.
//

import UIKit
import PlaygroundSupport
import ARKit

@available(iOS 11.0, *)
@objc(Ch1Page2LiveViewController)
public class Ch1Page2LiveViewController: StatusLiveViewController, ARSCNViewDelegate, SCNPhysicsContactDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var sceneView: ARSCNView!
    @IBOutlet private weak var dishView: UIView!
    @IBOutlet private weak var placeView: UIView!
    @IBOutlet private weak var skillView: UIView!
    
    // MARK: - Properties
    
    private var didInitializeScene = false
    private var chosenCountries: [Country] = []
    
    // MARK: - ViewController Lifecycle
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setupScene()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    // MARK: - Actions
    
    public func setupScene() {
        if let view = self.view as? ARSCNView {
            sceneView = view
            sceneView.delegate = self
            sceneView.scene.physicsWorld.contactDelegate = self
            sceneView.pointOfView?.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: SCNSphere(radius: 0.0001), options: [:]))
            sceneView.pointOfView?.physicsBody?.categoryBitMask = 0
            sceneView.pointOfView?.physicsBody?.collisionBitMask = 0
            sceneView.pointOfView?.physicsBody?.contactTestBitMask = -1
        }
    }
    
    public func addElements(position: SCNVector3) {
        
        let containerNode = SCNNode()
        let nodesInFile = SCNNode.allNodes(from: "BioDiversityBoxes.scn")
        
        nodesInFile.forEach { (node) in
            if let nodeName = node.name, let country = Country(rawValue: nodeName) {
                if chosenCountries.contains(country) {
                    containerNode.addChildNode(node)
                }
            }
        }
        
        containerNode.position = position
        sceneView.scene.rootNode.addChildNode(containerNode)
    }
    
    // MARK: - PlaygroundLiveViewMessageHandler
    
    public override func receive(_ message: PlaygroundValue) {
        
        didInitializeScene = false
        
        sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode()
        }
        
        switch message {
        case .array(let countries):
            view.gestureRecognizers?.removeAll()
            countries.forEach({
                switch $0 {
                case .string(let country):
                    chosenCountries.append(Country(rawValue: country)!)
                    break
                default:
                    break
                }
            })
            break
        default:
            break
        }
        
    }
    
    // MARK: - ARSCNViewDelegate
    
    public func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        DispatchQueue.main.async {
            if !self.didInitializeScene {
                self.say(message: "Plane detected!")
                if let camera = self.sceneView.session.currentFrame?.camera {
                    self.didInitializeScene = true
                    var translation = matrix_identity_float4x4
                    translation.columns.3.z = -1.0
                    let transform = camera.transform * translation
                    let position = SCNVector3(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
                    self.addElements(position: position)
                    self.showCompletion()
                }
            }
        }
    }
    
    // MARK: - SCNPhysicsContactDelegate
    
    public func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        if let camera = sceneView.pointOfView {
            if camera == contact.nodeA || camera == contact.nodeB {
                self.showCompletion()
            }
        }
    }
    
}
