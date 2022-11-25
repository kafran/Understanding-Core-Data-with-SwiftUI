//
//  UnderstandingCoreDataApp.swift
//  UnderstandingCoreData
//
//  Created by Kolmar Kafran on 25/11/22.
//

import SwiftUI

@main
struct UnderstandingCoreDataApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ItemListCardView()
                    .environment(
                        \.managedObjectContext,
                        PersistenceController.shared.container.viewContext
                    )
            }
        }
    }
}
