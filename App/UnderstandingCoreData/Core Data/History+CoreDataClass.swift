//
//  History+CoreDataClass.swift
//  UnderstandingCoreData
//
//  Created by Kolmar Kafran on 18/11/22.
//
//

import Foundation
import CoreData

@objc(History)
public class History: NSManagedObject {

}

extension History {
    var priceDecimal: Decimal {
        self.price as? Decimal ?? Decimal(0)
    }
}
