//
//  ThemeView.swift
//  UnderstandingCoreData
//
//  Created by Kolmar Kafran on 18/11/22.
//

import SwiftUI

struct ThemeView: View {
    let theme: Theme
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(theme.mainColor)
            Label(theme.name, systemImage: "paintpalette")
                .padding(4)
        }
        .foregroundColor(theme.accentColor)
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView(theme: .lavender)
    }
}
