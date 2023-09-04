//
//  PeculiaritiesExt.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 1.09.2023.
//

import SwiftUI

struct PeculiaritiesStackExt: View {
    var peculiarities: [String] = []
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                ForEach((peculiarities).filter { $0.count >= 19 }, id: \.self) { item in
                    PeculiaritiesHStaclExt(text: item)
                }
            }
            HStack {
                ForEach((peculiarities).filter { $0.count < 19 }, id: \.self) { item in
                    PeculiaritiesHStaclExt(text: item)
                }
            }
        }
    }
}

struct PeculiaritiesExt_Previews: PreviewProvider {
    static var previews: some View {
        PeculiaritiesStackExt()
    }
}
