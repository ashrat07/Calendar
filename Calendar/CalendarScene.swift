//
//  Copyright 2013-2018 Microsoft Inc.
//

import ARKit

class CalendarScene {

    private static let colors : [UIColor] = [
        UIColor(red:1.00, green:0.23, blue:0.19, alpha:1.0),
        UIColor(red:1.00, green:0.18, blue:0.33, alpha:1.0),
        UIColor(red:1.00, green:0.58, blue:0.00, alpha:1.0),
        UIColor(red:1.00, green:0.80, blue:0.00, alpha:1.0),
        UIColor(red:0.35, green:0.34, blue:0.84, alpha:1.0),
        UIColor(red:0.20, green:0.67, blue:0.86, alpha:1.0),
        UIColor(red:0.56, green:0.56, blue:0.58, alpha:1.0)
    ]

    private static let floorColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    private static let stripeColor = UIColor.red
    private static let gridColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
    private static let titleColor = UIColor(red: 0.35, green: 0.34, blue: 0.84, alpha: 1.0)

    private let scene: SCNScene
    private let x: Float
    private let y: Float
    private let z: Float
    private let config: CalendarConfig
    private let agendas: [Agenda]

    init(_ scene: SCNScene, _ x: Float, _ y: Float, _ z: Float, _ config: CalendarConfig, _ agendas: [Agenda]) {
        self.scene = scene
        self.x = x
        self.y = y
        self.z = z
        self.config = config
        self.agendas = agendas
        createFloor()
        createGrid()
        createBoxes()
    }

    private func createFloor() {
        let node = SCNNode()
        addBox(to: node, config.cellWidth, config.lineWidth, 20 * Float(config.length), 0, 0, 10 * Float(config.length), 0, CalendarScene.floorColor)
//        addBox(to: node, 10 * config.lineWidth, config.lineWidth, 20 * Float(config.length), -10 * config.lineWidth, 0, 10 * Float(config.length), 0, CalendarScene.stripeColor)
        addBox(to: node, 10 * config.lineWidth, config.lineWidth, 20 * Float(config.length), -35 * config.lineWidth, 0, 10 * Float(config.length), 0, CalendarScene.stripeColor)
        addBox(to: node, 10 * config.lineWidth, config.lineWidth, 20 * Float(config.length), Float(config.width), 0, 10 * Float(config.length), 0, CalendarScene.stripeColor)
        scene.rootNode.addChildNode(node)
    }

    private func createGrid() {
        let node = SCNNode()
        for i in 0...config.length {
            for j in 0...config.width {
                addBox(to: node, config.lineWidth, config.cellHeight * Float(config.height), config.lineWidth, Float(j), 0, -Float(i), 0, CalendarScene.gridColor)
            }
        }
        for i in 0...config.length {
            for j in 0...config.height {
                addBox(to: node, config.cellWidth * Float(config.width), config.lineWidth, config.lineWidth, 0, Float(j), -Float(i), 0, CalendarScene.gridColor)
            }
        }
        for i in 0...config.width {
            for j in 0...config.height {
                addBox(to: node, config.lineWidth, config.lineWidth, config.cellLength * Float(config.length), Float(i), Float(j), 0, 0, CalendarScene.gridColor)
            }
        }
        scene.rootNode.addChildNode(node)
    }

    private func createBoxes() {
        let node = SCNNode()
        for (dayIndex, agenda) in agendas.enumerated() {
            for (eventIndex, _) in agenda.events.enumerated() {
                let randomIndex = Utility.getRandomInt(max: CalendarScene.colors.count)
                let color = CalendarScene.colors[randomIndex]
                addBox(to: node, config.cellWidth, config.cellHeight, config.cellLength, 0, Float(eventIndex), -Float(dayIndex), config.chamferRadius, color)
            }
        }
        scene.rootNode.addChildNode(node)
    }

    private func addBox(to node: SCNNode, _ w: Float, _ h: Float, _ l: Float, _ x: Float, _ y: Float, _ z: Float, _ chamferRadius: Float, _ color: UIColor) {
        let box = SCNBox(width: cg(w), height: cg(h), length: cg(l), chamferRadius: cg(chamferRadius))
        let matrix = SCNMatrix4Translate(translate(x - 0.5, y, z - 0.5), w / 2, h / 2, -l / 2)
        node.addChildNode(createNode(box, matrix, color))
    }

    private func createNode(_ geometry: SCNGeometry, _ matrix: SCNMatrix4, _ color: UIColor) -> SCNNode {
        let material = SCNMaterial()
        material.diffuse.contents = color
        // use the same material for all geometry elements
        geometry.firstMaterial = material
        let node = SCNNode(geometry: geometry)
        node.transform = matrix
        return node
    }

    private func translate(_ x: Float, _ y: Float, _ z: Float = 0) -> SCNMatrix4 {
        return SCNMatrix4MakeTranslation(self.x + x * config.cellWidth, self.y + y * config.cellHeight, self.z + z * config.cellLength)
    }

    private func cg(_ f: Float) -> CGFloat { return CGFloat(f) }

}

extension SCNMatrix4 {
    func scale(_ s: Float) -> SCNMatrix4 { return SCNMatrix4Scale(self, s, s, s) }
}
