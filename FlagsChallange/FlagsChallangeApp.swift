//
//  FlagsChallangeApp.swift
//  FlagsChallange
//
//  Created by Priya Gnaneshwaran on 24/07/25.
//

import SwiftUI

@main
struct FlagsChallangeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
