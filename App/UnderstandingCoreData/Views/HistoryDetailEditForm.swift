//
//  HistoryDetailEditForm.swift
//  UnderstandingCoreData
//
//  Created by Kolmar Kafran on 25/11/22.
//

import SwiftUI

struct HistoryDetailEditForm: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var item: Item
    @ObservedObject var history: History
    let editMode: DetailEditMode

    var items: String {
        history.quantity <= 1 ? "item" : "items"
    }

    var total: Double {
        // FIXME: Remove this nil-coalescing
        Double(history.quantity) * (history.price?.doubleValue ?? 0.0)
    }

    var body: some View {
        VStack {
            Form {
                Section {
                    Stepper(
                        "\(history.quantity) \(items)",
                        value: $history.quantity,
                        in: 0 ... 99
                    )
                    TextField(
                        "Price",
                        value: .init(
                            get: { history.price as? Decimal },
                            set: { history.price = $0 as? NSDecimalNumber }
                        ),
                        format: .currency(code: Currency.code)
                    )
                    .keyboardType(.decimalPad)
                    .submitLabel(.done)
                }

                HStack {
                    Text("Total")
                    Spacer()
                    Text(self.total, format: .currency(code: Currency.code))
                }
            }
            .padding()
            .navigationTitle("\(item.nameString)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.save()
                        dismiss()
                    } label: {
                        Text(editMode.rawValue)
                    }
                    .disabled(history.quantity == 0)
                }

                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
        }
    }
    
    private func save() {
        guard history.managedObjectContext?.hasChanges == true else {
            return // no changes to persist
        }
        
        history.item = item
        history.date = Date.now
        
        do {
            try history.managedObjectContext?.save()
        } catch {
            print("Something went wrong while saving the child context: \(error)")
        }
    }
}

// struct HistoryDetailEditForm_Previews: PreviewProvider {
//    static var previews: some View {
//        HistoryDetailEditForm()
//    }
// }
