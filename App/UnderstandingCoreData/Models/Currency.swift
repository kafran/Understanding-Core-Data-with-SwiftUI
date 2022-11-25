//
//  Currency.swift
//  UnderstandingCoreData
//
//  Created by Kolmar Kafran on 25/11/22.
//

import Foundation

// FIXME: Move this to a better Settings
struct Currency {
    static let code = Locale.current.currencyCode ?? "USD"
}
