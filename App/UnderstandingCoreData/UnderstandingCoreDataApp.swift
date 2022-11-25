//
//  UnderstandingCoreDataApp.swift
//  UnderstandingCoreData
//
//  Created by Kolmar Kafran on 25/11/22.
//

import SwiftUI

@main
struct UnderstandingCoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
