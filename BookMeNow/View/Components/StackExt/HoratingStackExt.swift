//
//  HoratingStackExt.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 3.09.2023.
//

import SwiftUI

struct HoratingStackExt: View {
    var horating: Int
    var horatingName: String
    var body: some View {
        HStack{
            Image(systemName: "star.fill")
            Text("\(horating ?? 0)")
            Text(horatingName ?? "")
        }
        .foregroundColor(.orange.opacity(0.7))
        .padding(4)
        .background(.yellow.opacity(0.25))
        .cornerRadius(5)    }
}

//struct HoratingStackExt_Previews: PreviewProvider {
//    static var previews: some View {
//        HoratingStackExt()
//    }
//}
