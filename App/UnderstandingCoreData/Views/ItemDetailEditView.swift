//
//  DetailEditView.swift
//  UnderstandingCoreData
//
//  Created by Kolmar Kafran on 18/11/22.
//

import SwiftUI

struct ItemDetailEditView: View {
    private let childContext: CoreDataChildContext<Item>
    private let editMode: DetailEditMode

    init(childContext: CoreDataChildContext<Item>, editMode: DetailEditMode) {
        self.childContext = childContext
        self.editMode = editMode
    }

    var body: some View {
        NavigationView {
            ItemDetailEditForm(item: childContext.entity, editMode: editMode)
        }
    }
}
