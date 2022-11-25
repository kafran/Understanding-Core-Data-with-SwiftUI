//
//  ItemDetailEditForm.swift
//  UnderstandingCoreData
//
//  Created by Kolmar Kafran on 24/11/22.
//

import SwiftUI

struct ItemDetailEditForm: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var item: Item
    let editMode: DetailEditMode

    var body: some View {
        Form {
            Section(header: Text("Item Info")) {
                TextField("Name", text: $item.nameString)
                ThemePicker(selection: $item.themeEnum)
            }
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button(editMode.rawValue) {
                    self.save()
                    dismiss()
                }
                .disabled(item.nameString.isEmpty)
            }
        }
    }

    /// Push the childContext to the parentContext
    private func save() {
        guard item.managedObjectContext?.hasChanges == true else {
            return // no changes to persist
        }
        do {
            try item.managedObjectContext?.save()
        } catch {
            print("Something went wrong while saving the child context: \(error)")
        }
    }
}

struct ItemDetailEditForm_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ItemDetailEditForm(item: Item.example, editMode: .edit)
        }
    }
}
