//
//  ARViewContainer.swift
//  Fooney
//
//  Created by Adryan Eka Vandra on 21/03/23.
//

import SwiftUI
import RealityKit
import SceneKit
import ARKit

struct ARViewContainer: UIViewRepresentable {
    @ObservedObject var recognized: ModelObserable = .shared

    func makeUIView(context: Context) -> ARView {
        let configuration = ARFaceTrackingConfiguration()
        recognized.arView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        let view = recognized.arView
        return view
    }

    func updateUIView(_ uiView: ARView, context: Context) {
//        var displayedText = SCNText()

//        // let's keep the number of anchors to no more than 1 for this demo
//        if !recognized.arView.scene.anchors.isEmpty {
//            recognized.arView.scene.anchors.removeAll()
//        }

//        let configuration = ARFaceTrackingConfiguration()
//        recognized.arView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
//        // create the AR Text to place on the screen
//        displayedText = SCNText(string: recognized.recognizedExpression, extrusionDepth: 0)
//        let material = SCNMaterial()
//        material.diffuse.contents = UIColor.magenta
//        displayedText.materials = [material]
//
//        let randomColor = generateRandomColor()
//
//        let shader = SimpleMaterial(color: randomColor, roughness: 1, isMetallic: true)
//        let text = MeshResource.generateText(
//            "\(recognized.recognizedExpression)",
//            extrusionDepth: 0.05,
//            font: .init(name: "Helvetica", size: 0.05)!,
//            alignment: .center
//        )
//
//        let textEntity = ModelEntity(mesh: text, materials: [shader])
//
//        let transform = recognized.arView.cameraTransform
//
//        // set the transform (the 3d location) of the text to be near the center of the camera, and 1/2 meter away
//        let trans = simd_float4x4(transform.matrix)
//        let anchEntity = AnchorEntity(world: trans)
//        textEntity.position.z -= 0.5 // place the text 1/2 meter away from the camera along the Z axis
//
//        // find the width of the entity in order to have the text appear in the center
//        let minX = text.bounds.min.x
//        let maxX = text.bounds.max.x
//        let minY = text.bounds.min.y
//        let maxY = text.bounds.max.y
//        let height = maxY - minY
//        let width = maxX - minX
//        let xPos = width / 2
//        let yPos = height / 2
//
//        //        textEntity.position.x = transform.translation.x - xPos
//        textEntity.position.y = transform.translation.y - yPos
//
//        anchEntity.addChild(textEntity)
//
//        // add this anchor entity to the scene
//        recognized.arView.scene
//        recognized.arView.scene.addAnchor(anchEntity)
    }

//    func generateRandomColor() -> UIColor {
//        let redValue = CGFloat(drand48())
//        let greenValue = CGFloat(drand48())
//        let blueValue = CGFloat(drand48())
//
//        let randomColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
//
//        return randomColor
//    }
}
