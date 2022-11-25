//
//  DetailEditMode.swift
//  UnderstandingCoreData
//
//  Created by Kolmar Kafran on 24/11/22.
//

import Foundation

enum DetailEditMode: String, Identifiable {
    case add = "Add"
    case edit = "Save"

    var id: String {
        rawValue
    }
}
