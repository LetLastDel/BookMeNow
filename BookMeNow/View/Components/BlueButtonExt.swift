//
//  BlueButtonExt.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 3.09.2023.
//

import SwiftUI

struct BlueButtonExt: View {
    var action: () -> Void
    var text: String
    var body: some View {
        VStack{
            Button{
                action()
            } label: {
                Text(text)
                    .font(Font.custom("SF Pro Display", size: 16))
                    .frame(maxWidth: .infinity, maxHeight: 45)
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(15)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
            }
        }
    }
}

//struct BlueButtonExt_Previews: PreviewProvider {
//    static var previews: some View {
//        BlueButtonExt()
//    }
//}
