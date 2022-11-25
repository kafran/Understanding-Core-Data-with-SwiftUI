//
//  Persistence.swift
//  UnderstandingCoreData
//
//  Created by Kolmar Kafran on 25/11/22.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    // Provides fake random Items for the PreviewProvider
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0 ..< 10 {
            let newItem = Item(context: viewContext)
            newItem.name = "Item \(i)"
            newItem.theme = Theme.allCases.randomElement()?.rawValue
            // Adds multiple random historical transactions to the Item
            for h in 1 ..< Int.random(in: 1 ... 11) {
                let newHistory = History(context: viewContext)
                newHistory.item = newItem
                newHistory.price = Decimal(h) as NSDecimalNumber
                newHistory.quantity = Int16(h)
                newHistory.date = Date.now
            }
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and
            // terminate. You should
            // not use this function in a shipping application, although it may be
            // useful during
            // development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "UnderstandingCoreData")
        if inMemory {
            container.persistentStoreDescriptions.first!
                .url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error
                // appropriately.
                // fatalError() causes the application to generate a crash log and
                // terminate. You
                // should not use this function in a shipping application, although it
                // may be useful
                // during development.

                // Typical reasons for an error here include:
                // * The parent directory does not exist, cannot be created, or
                // disallows writing.
                // * The persistent store is not accessible, due to permissions or data
                // protection when the device is locked.
                // * The device is out of space.
                // * The store could not be migrated to the current model version.
                // Check the error message to determine what the actual problem was.
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    func save() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }

    func newItem() -> Item {
        let newItem = Item(context: container.viewContext)
        newItem.name = ""
        return newItem
    }
}
