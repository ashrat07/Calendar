//
//  Copyright 2013-2018 Microsoft Inc.
//

import ARKit
import SceneKit

let CollisionCategoryPlane = 1 << 0
let CollisionCategoryCube = 1 << 1

class CalendarViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!

    var scene: CalendarScene?
    private var agendas = [Agenda]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the view's delegate
        sceneView.delegate = self

        // Create a new scene
        sceneView.scene = SCNScene()
        // Use default lighting
        sceneView.autoenablesDefaultLighting = true
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]

        addGestures()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        agendas = Utility.getRandomAgendas(daysPrevious: 0, daysNext: 9, minEventCount: 0, maxEventCount: 4)
        
        // Run the view's session
        sceneView.session.run(getSessionConfiguration())
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause the view's session
        sceneView.session.pause()
    }

    private func getSessionConfiguration() -> ARConfiguration {
        if ARWorldTrackingConfiguration.isSupported {
            // Create a session configuration
            let configuration = ARWorldTrackingConfiguration()
            configuration.planeDetection = .horizontal
            return configuration
        } else {
            // Slightly less immersive AR experience due to lower end processor
            return AROrientationTrackingConfiguration()
        }
    }

    private func addGestures() {
        let swiftDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        swiftDown.direction = .down
        self.view.addGestureRecognizer(swiftDown)

        let swiftUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        swiftUp.direction = .up
        self.view.addGestureRecognizer(swiftUp)

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        self.view.addGestureRecognizer(tap)
    }

    @objc private func handleSwipe(sender: UISwipeGestureRecognizer) {
        if (sender.direction == .down) {

        } else {

        }
    }

    @objc private func handleTap(sender: UITapGestureRecognizer) {
        let location = sender.location(in: self.view)
        let x = location.x / self.view.bounds.size.width
        if (x < 0.5) {

        } else {

        }
    }

}

extension CalendarViewController: ARSCNViewDelegate {


    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // We need async execution to get anchor node's position relative to the root
        DispatchQueue.main.async {
            if let planeAnchor = anchor as? ARPlaneAnchor {
                // For a first detected plane
                if self.scene == nil {
                    // get center of the plane
                    let config = CalendarConfig.standard
                    let x = planeAnchor.center.x + node.position.x
                    let y = planeAnchor.center.y + node.position.y
                    let z = planeAnchor.center.z + node.position.z
                    self.scene = CalendarScene(self.sceneView.scene, x, y, z, config, self.agendas)
                }
            }
        }
    }

//    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
//        guard let estimate = sceneView.session.currentFrame?.lightEstimate
//            else {
//                return
//        }
//
//        // A value of 1000 is considered neutral, lighting environment intensity normalizes
//        // 1.0 to neutral so we need to scale the ambientIntensity value
//        let intensity = estimate.ambientIntensity / 1000.0
//        sceneView.scene.lightingEnvironment.intensity = intensity
//    }

}
