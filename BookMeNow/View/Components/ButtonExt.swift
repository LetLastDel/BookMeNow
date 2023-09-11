//
//  ButtonExt.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 31.08.2023.
//

import SwiftUI

struct ButtonExt: View {
    var text: String
    var image: String
    @State var pushed = false
    var showDivider: Bool
    
    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25)
            VStack(alignment: .leading) {
                Text(text)
                Text("Все самое необходимое")
                    .foregroundColor(.gray)
                if pushed {
                    Text("")
                }
            }
            Spacer()
            Button {
                withAnimation {
                    self.pushed.toggle()
                }
            } label: {
                Image(pushed ? "arrow" : "arrow")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25)
                    .rotationEffect(Angle(degrees: pushed ? 90 : 0))
            }
            .foregroundColor(.gray)
        }
        .padding(.horizontal, 10)
        .background(.gray.opacity(0.05))
        .frame(height: pushed ? nil : 45)
        .overlay(alignment: .bottom) {
            if showDivider{
                Divider()
                    .padding(.horizontal, 15)
                    .offset(y:-2.5)
            }
        }
        
    }
}

struct ButtonExt_Previews: PreviewProvider {
    static var previews: some View {
        ButtonExt(text: "Удобства", image: "ok", showDivider: true)
    }
}
