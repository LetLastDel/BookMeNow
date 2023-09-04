//
//  HStackExt.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 31.08.2023.
//

import SwiftUI

struct PeculiaritiesHStaclExt: View {
    var text: String
    var body: some View {
        HStack{
            Text(text)
                .font(Font.custom("SF Pro Display", size: 16))
                .foregroundColor(.gray)
        }
        .padding(4)
        .background(.gray.opacity(0.05))
        .cornerRadius(5)
    }
}
struct HStackExt_Previews: PreviewProvider {
    static var previews: some View {
        PeculiaritiesHStaclExt(text: "Бесплатный Wifi на всей территории отеля")
    }
}
