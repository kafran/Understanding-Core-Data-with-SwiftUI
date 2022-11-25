//
//  CardView.swift
//  UnderstandingCoreData
//
//  Created by Kolmar Kafran on 25/10/22.
//

import SwiftUI

struct ItemCardView: View {
    let item: Item
    let currency = Locale.current.currency?.identifier ?? "BRL"

    private var totalQuantity: Int {
        item.itemHistory.reduce(0) { result, history in
            result + Int(history.quantity)
        }
    }

    private var totalPrice: Decimal {
        item.itemHistory.reduce(0) { result, history in
            result + history.priceDecimal
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(item.nameString)
                .font(.title2)
            Spacer()
            HStack {
                Label("\(self.totalQuantity)", systemImage: "basket")
                Spacer()
                Label {
                    Text(self.totalPrice, format: .currency(code: currency))
                } icon: {
                    Image(systemName: "banknote")
                }
            }
        }
        .foregroundColor(item.themeEnum.accentColor)
        .padding()
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        ItemCardView(item: Item.example)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
