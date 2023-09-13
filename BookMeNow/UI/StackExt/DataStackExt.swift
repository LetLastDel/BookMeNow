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
                        .font(Fonts.customFontRegular16px)
                        .frame(width: 150, alignment: .leading)
                    if spacer{ Spacer() }
                    Text(value ?? "")
                        .font(Fonts.customFontRegular16px)
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
