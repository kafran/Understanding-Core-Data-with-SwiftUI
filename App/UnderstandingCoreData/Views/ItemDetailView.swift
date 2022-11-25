//
//  ItemDetailView.swift
//  UnderstandingCoreData
//
//  Created by Kolmar Kafran on 24/11/22.
//

import SwiftUI

struct ItemDetailView: View {
    @ObservedObject var item: Item

    @State var isHistoryExpanded = false
    @State var itemEditMode: DetailEditMode?
    @State var historyEditMode: DetailEditMode?

    var body: some View {
        List {
            DisclosureGroup(isExpanded: $isHistoryExpanded) {
                ForEach(item.itemHistory) { history in
                    Text(history.date?.formatted() ?? "Unknown Date")
                }

            } label: {
                HStack {
                    Text("History")
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    itemEditMode = .edit
                }
            }

            ToolbarItem {
                Button {
                    historyEditMode = .add
                } label: {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
        .sheet(item: $itemEditMode) { editMode in
            ItemDetailEditView(
                config: .init(editEntity: item),
                editMode: editMode
            )
        }
        .sheet(item: $historyEditMode) { editMode in
            HistoryDetailEditView()
                .presentationDetents([.medium])
        }
        .navigationTitle(item.nameString)
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ItemDetailView(item: Item.example)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
