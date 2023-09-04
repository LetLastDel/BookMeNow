//
//  DataStackExt.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 3.09.2023.
//

import SwiftUI

struct DataStackExt: View {
    var data: [(String, String?)]
    var spacer: Bool
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(data, id: \.0) { key, value in
                HStack{
                    Text(key)
                        .foregroundColor(.gray)
                        .font(Font.custom("SF Pro Display", size: 16))
                        .frame(width: 150, alignment: .leading)
                    if spacer{ Spacer() }
                    Text(value ?? "")
                        .font(Font.custom("SF Pro Display", size: 16))

                }
                .padding(.bottom, 15)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(10)
    }
}

//struct DataStackExt_Previews: PreviewProvider {
//    static var previews: some View {
//        DataStackExt()
//    }
//}
