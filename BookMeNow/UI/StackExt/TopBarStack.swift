//
//  TopBarStack.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 2.09.2023.
//

import SwiftUI

struct TopBarStack: View {
    var title: String
    @Binding var presentationMode: PresentationMode
    var body: some View {
        HStack{
            Text(title)
                .frame(maxWidth: .infinity)
                .font(Fonts.customFontMedium18px)
        }.frame(maxWidth: .infinity)
            .overlay(alignment: .leading) {
                Button {
                    $presentationMode.wrappedValue.dismiss()
                } label: {
                    Image("backButton")
                        .resizeImg()
                }.padding(.horizontal, 16)
            }
    }
}

