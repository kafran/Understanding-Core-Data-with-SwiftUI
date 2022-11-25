//
//  HistoryDetailEditView.swift
//  UnderstandingCoreData
//
//  Created by Kolmar Kafran on 24/11/22.
//

import SwiftUI

struct HistoryDetailEditView: View {
    private let itemChildContext: CoreDataChildContext<Item>
    private let editMode: DetailEditMode

    init(
        itemChildContext: CoreDataChildContext<Item>,
        editMode: DetailEditMode
    ) {
        self.itemChildContext = itemChildContext
        self.editMode = editMode
    }

    var body: some View {
        NavigationView {
            HistoryDetailEditForm(
                item: itemChildContext.entity,
                history: History(context: itemChildContext.childContext!),
                editMode: editMode
            )
        }
    }
}

// struct HistoryDetailEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        HistoryDetailEditView()
//    }
// }
