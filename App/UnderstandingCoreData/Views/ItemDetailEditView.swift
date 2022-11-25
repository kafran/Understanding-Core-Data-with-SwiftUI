//
//  DetailEditView.swift
//  UnderstandingCoreData
//
//  Created by Kolmar Kafran on 18/11/22.
//

import SwiftUI

struct ItemDetailEditView: View {
    private let config: CoreDataChildContext<Item>
    private let editMode: DetailEditMode

    init(config: CoreDataChildContext<Item>, editMode: DetailEditMode) {
        self.config = config
        self.editMode = editMode
    }

    var body: some View {
        NavigationView {
            ItemDetailEditForm(item: config.entity, editMode: editMode)
        }
    }
}
