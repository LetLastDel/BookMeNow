//
//  TextFieldExt.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 31.08.2023.
//

import SwiftUI

struct TextFieldExt: View {
    var fieldName: String
    @Binding var text: String
    @State var taped = false
    var promt: Bool?
    var paymentButtonPressed: Bool

    var body: some View {
        VStack(alignment: .leading){
            if taped || !text.isEmpty {
                Text(fieldName)
                    .foregroundColor(.gray)
                    .font(.callout)
            }
            TextField(taped ? "" : fieldName, text: $text)
                .onChange(of: text, perform: { newValue in
                    withAnimation {
                        self.taped = true
                    }
                })
        }
        .frame(maxHeight: 35)
        .padding()
        .background((promt ?? false || (paymentButtonPressed && text.isEmpty)) ? Color.errorColor : .gray.opacity(0.1))
        .cornerRadius(10)
    }
}

