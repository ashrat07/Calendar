//
//  ViewController.swift
//  Calendar
//
//  Created by Ashish Rathore on 23/07/18.
//  Copyright © 2018 Microsoft. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!

    let textures = [
        "mercury.jpg",
        "venus.jpg",
        "earth.png",
        "mars.jpg"
    ]
    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!

//        let scene = SCNScene()
//        let box = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0)
//        let material = SCNMaterial()
//        material.diffuse.contents = UIImage(named: "brick.jpg")
//        box.materials = [material]
//        let boxNode = SCNNode(geometry: box)
//        boxNode.position = SCNVector3(0, 0, -0.5)
//        scene.rootNode.addChildNode(boxNode)

        let scene = SCNScene()
        let sphere = SCNSphere(radius: 0.1)
        let material = SCNMaterial()
        let texture = textures[index]
        index += 1
        material.diffuse.contents = UIImage(named: texture)
        sphere.materials = [material]
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = SCNVector3(0, 0, -0.5)
        scene.rootNode.addChildNode(sphereNode)

        // Set the scene to the view
        sceneView.scene = scene

        registerGestureRecognizers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    private func registerGestureRecognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc func tapped(recognizer :UITapGestureRecognizer) {
        let sceneView = recognizer.view as! ARSCNView
        let touchLocation = recognizer.location(in: sceneView)
        let hitResults = sceneView.hitTest(touchLocation, options: [:])
        if !hitResults.isEmpty {
            if index >= self.textures.count {
                index = 0
            }
            guard let hitResult = hitResults.first else {
                return
            }
            let node = hitResult.node
            node.geometry?.firstMaterial?.diffuse.contents = UIImage(named: textures[index])
            index += 1
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
