//
//  SpatialLUTIApp.swift
//  SpatialLUTI
//
//  Created by Matt Biddulph on 1/21/24.
//

import SwiftUI

@main
struct SpatialLUTIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.progressive), in: .progressive)
    }
}
