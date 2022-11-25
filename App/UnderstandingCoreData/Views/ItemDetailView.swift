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
    
    private var totalPrice: Decimal {
        item.itemHistory.reduce(0) { result, history in
            result + history.priceDecimal
        }
    }

    var body: some View {
        List {
            DisclosureGroup(isExpanded: $isHistoryExpanded) {
                ForEach(item.itemHistory) { history in
                    HStack {
                        Text(history.date?.formatted() ?? "Unknown Date")
                        Spacer()
                        Text("Total: \(totalPrice, format: .currency(code: Currency.code))")
                    }
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
        .sheet(item: $itemEditMode, onDismiss: persistData) { editMode in
            ItemDetailEditView(
                childContext: .init(editEntity: item),
                editMode: editMode
            )
        }
        .sheet(item: $historyEditMode, onDismiss: persistData) { editMode in
            HistoryDetailEditView(
                itemChildContext: .init(editEntity: item),
                editMode: editMode
            )
            .presentationDetents([.medium])
        }
        .navigationTitle(item.nameString)
    }
    
    private func persistData() {
        PersistenceController.shared.save()
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
