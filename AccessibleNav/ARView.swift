//
//  ARView.swift
//  AccessibleNav
//
//  Created by Isabela Moise on 2023-07-08.
//

import SwiftUI
import RealityKit
import Euclid
import ARKit
import FocusEntity

struct ARContentView: View {
    var body: some View {
        RealityKitView()
    .ignoresSafeArea()
    }
}

struct RealityKitView: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let view = ARView()
        
        // Start AR session
        let session = view.session
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        session.run(config)
        
        // Add coaching overlay
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.session = session
        coachingOverlay.goal = .horizontalPlane
        view.addSubview(coachingOverlay)
        
        
        // Handle ARSession events via delegate
        context.coordinator.view = view
        session.delegate = context.coordinator
        
        // Handle taps
        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: context.coordinator,
                action: #selector(Coordinator.handleTap)
            )
        )
        
        return view
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func updateUIView(_ view: ARView, context: Context) {
    }
}

class Coordinator: NSObject, ARSessionDelegate {
    weak var view: ARView?
    var focusEntity: FocusEntity?

    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        guard let view = self.view else { return }
        debugPrint("Anchors added to the scene: ", anchors)
        self.focusEntity = FocusEntity(on: view, style: .classic(color: .yellow))
    }
    
    @objc func handleTap() {
        guard let view = self.view, let focusEntity = self.focusEntity else { return }

        // Create a new anchor to add content to
        let anchor = AnchorEntity()
        view.scene.anchors.append(anchor)
        
        // Define material
        
        var material = PhysicallyBasedMaterial()
        
        material.baseColor = PhysicallyBasedMaterial.BaseColor(tint:.gray)
        material.roughness = PhysicallyBasedMaterial.Roughness(floatLiteral: 0.5)
        if let normalResource = try? TextureResource.load(named:
        "Texture/Universal") {
            let normalMap = MaterialParameters.Texture(normalResource)
            material.normal = PhysicallyBasedMaterial.Normal(texture:normalMap)
        }

        // Add a Box entity with a blue material
        
        let topFace = [
            Vertex(Vector(-0.5, 0, 0)),
            Vertex(Vector(0.5, 0, 0)),
            Vertex(Vector(0.5, 0.3, 1)),
            Vertex(Vector(-0.5, 0.3, 1)),
        ]
        let leftFace = [
            Vertex(Vector(-0.5, 0, 0)),
            Vertex(Vector(-0.5, 0, 1)),
            Vertex(Vector(-0.5, 0.3, 1)),
        ]
        let rightFace = [
            Vertex(Vector(0.5, 0, 0)),
            Vertex(Vector(0.5, 0, 1)),
            Vertex(Vector(0.5, 0.3, 1)),
        ]
        let backFace = [
            Vertex(Vector(-0.5, 0, 1)),
            Vertex(Vector(0.5, 0, 1)),
            Vertex(Vector(0.5, 0.3, 1)),
            Vertex(Vector(-0.5, 0.3, 1)),
        ]
        
        let polygons = [
            Polygon(topFace, material: UIColor.red)!,
            Polygon(leftFace, material: UIColor.red)!,
            Polygon(rightFace, material: UIColor.red)!,
            Polygon(backFace, material: UIColor.red)!
        ]

        let polygonMesh = Mesh.convexHull(of: polygons)
        
        let cube = Mesh.cube(size: 0.001, material: UIColor.blue)
        let mesh = cube.merge(polygonMesh).makeWatertight()
        
        
        
        
        
        
        let rampEntity = try! ModelEntity(mesh)
        rampEntity.position = focusEntity.position
        
        let radians = 180 * Float.pi / 180.0
        rampEntity.orientation = simd_quatf(angle: radians, axis: SIMD3(x: 0, y: 1, z: 0))
        
        
        var materials = rampEntity.model!.materials
        
        
        for i in materials.indices{
            materials[i] = material
        }
        
        rampEntity.model!.materials = materials
        

        anchor.addChild(rampEntity)
    }
}
