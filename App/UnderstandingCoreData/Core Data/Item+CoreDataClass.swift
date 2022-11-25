//
//  Item+CoreDataClass.swift
//  UnderstandingCoreData
//
//  Created by Kolmar Kafran on 18/11/22.
//
//

import CoreData
import Foundation

@objc(Item)
public class Item: NSManagedObject {}

extension Item {
//    override public func awakeFromInsert() {
//        setPrimitiveValue("", forKey: "name")
//        setPrimitiveValue(Theme.lavender.id, forKey: "theme")
//    }

    var nameString: String {
        name ?? "Unknown Item"
    }

    var itemHistory: [History] {
        history?.array as? [History] ?? []
    }

    var themeEnum: Theme {
        get { Theme(rawValue: theme ?? "") ?? .lavender }
        set { theme = newValue.id }
    }
}

extension Item {
    struct Data {
        var name = ""
        var theme: Theme = .lavender
    }
}

#if DEBUG
    // Provide a single Item to be used on PreviewProvider
    extension Item {
        static var example: Item {
            // Get one random Item from the in-memory Core Data store.
            let context = PersistenceController.preview.container.viewContext
            let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
            fetchRequest.fetchLimit = 1

            if let results = try? context.fetch(fetchRequest) {
                if let item = results.first {
                    return item
                }
            }
            return Item(context: context)
        }
    }
#endif
