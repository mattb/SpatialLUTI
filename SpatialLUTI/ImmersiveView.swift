//
//  ImmersiveView.swift
//  SpatialLUTI
//
//  Created by Matt Biddulph on 1/21/24.
//

import SwiftUI
import RealityKit
import RealityKitContent
import AVKit

let filenames = [
    "010519_JettySeafloor_NikonE200_10x_TriangleDiatom_edit",
    "042519_LakeBonneyMicrobialMat_NikonE200_10x_BF_PinkRotifer_edit",
    "042519_LakeBonneyMicrobialMat_NikonE200_20x_BF_PinkRotifer_edited",
    "042919_LakeBonneyMicrobialMat_NikonE200_40x_BF_Nostoc",
    "051319_LakeBonneyMicrobialMat_20x_BF_PinkRotifer_01_edit",
    "051319_LakeBonneyMicrobialMat_20x_BF_PinkRotifer_02_edited",
    "051319_LakeBonneyMicrobialMat_20x_BF_SpiralBall_edited",
    "051319_LakeBonneyMicrobialMat_40x_BF_PinkRotiferTun_edited",
    "051319_LakeBonneyMicrobialMat_40x_BF_StringThing_edited",
    "051319_LakeBonneyMicrobialMat_4x_BF_2Nematodes_edit",
    "110418_JettySeafloor_NikonE200_10x_Diatoms",
    "110418_JettySeafloor_NikonE200_10x_DiatomsRectangles",
    "110718_JettySeafloor_OlympusCKX41_40x_DiatomRectangle",
    "110818_Jetty_OlympusCKX41_40x_RedBlobExploding",
    "111118_DaytonsWallSeafloor_OlympusCKX41_10x_2Triangles",
    "111118_DaytonsWallSeafloor_OlympusCKX41_10x_TriangleOblong"
]

struct ImmersiveView: View {
    @State private var dragAmount = CGSize.zero
    @State private var players: [AVPlayer] = []

    var body: some View {
        RealityView { content in
            
            let xGrid: Float = 3
            let yGrid: Float = 3
            let scale: Float = 2
            let xSize: Float = 16 * scale
            let ySize: Float = 9 * scale
            
            var x: Float = 0
            var y: Float = 0
            for player in players {
                if x + y * Float(xGrid) < Float(xGrid * yGrid) {
                    let material = VideoMaterial(avPlayer: player)
                    let videoEntity = Entity()
                    let component = ModelComponent(mesh: .generateBox(width: xSize, height: ySize, depth: 0.001),
                                                   materials: [material])
                    videoEntity.components.set(component)
                    let xOffset: Float = (x - (xGrid / 2 - 0.5)) * xSize
                    videoEntity.transform.translation += SIMD3<Float>(xOffset, (y-1.5) * -ySize, -30.0)
                    content.add(videoEntity)
                    player.play()
                }
                x = x + 1
                if x == Float(xGrid) {
                    y = y + 1
                    x = 0
                }
            }
        }.onAppear {
            for filename in filenames {
                let player = AVPlayer(url: URL(string: "https://lifeundertheice.s3.amazonaws.com/\(filename)-playlist.m3u8")!)
                players.append(player)
            }
        }
    }
}
