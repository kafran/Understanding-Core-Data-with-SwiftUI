//
//  ContentView.swift
//  UnderstandingCoreData
//
//  Created by Kolmar Kafran on 22/10/22.
//

import CoreData
import SwiftUI

struct ItemListCardView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State private var isEditing = false
    @State private var editMode: DetailEditMode?

    @FetchRequest(
        sortDescriptors: [],
        animation: .default
    ) private var items: FetchedResults<Item>

    var body: some View {
        List {
            ForEach(items) { item in
                NavigationLink {
                    ItemDetailView(item: item)

                } label: {
                    ItemCardView(item: item)
                }
                .listRowSeparator(.hidden)
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 5)
                        .background(.clear)
                        .foregroundColor(item.themeEnum.mainColor)
                        .padding(
                            EdgeInsets(
                                top: 2,
                                leading: 10,
                                bottom: 2,
                                trailing: 10
                            )
                        )
                )
            }
            .onDelete(perform: deleteItems)
        }
        .environment(
            \.editMode,
            .constant(
                self.isEditing ?
                    EditMode.active :
                    EditMode.inactive
            )
        )
        .animation(.spring(), value: isEditing)
        .listStyle(.plain)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    self.isEditing.toggle()
                } label: {
                    Label(
                        "Delete",
                        systemImage: isEditing ? "checkmark.circle" : "trash"
                    )
                }
            }
            ToolbarItem {
                Button {
                    editMode = .add
                } label: {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
        .sheet(item: $editMode, onDismiss: persistData) { editMode in
            ItemDetailEditView(
                childContext: .init(parentContext: viewContext),
                editMode: editMode
            )
        }
    }

    private func persistData() {
        PersistenceController.shared.save()
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            PersistenceController.shared.save()
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListCardView()
            .environment(
                \.managedObjectContext,
                PersistenceController.preview.container.viewContext
            )
    }
}
