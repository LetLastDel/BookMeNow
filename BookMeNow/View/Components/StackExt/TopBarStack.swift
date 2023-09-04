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
                .font(Font.custom("SF Pro Display", size: 18))

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
//
//struct TopBarStack_Previews: PreviewProvider {
//    static var previews: some View {
//        TopBarStack(title: "Лучший пятиздвездочный отель в Хугарде, Египет")
//    }
//}
