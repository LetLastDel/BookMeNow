//
//  ButtonExt.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 3.09.2023.
//

import Foundation
import SwiftUI

extension Text{
    func size() -> some View{
        self
            .frame(maxWidth: .infinity, maxHeight: 45)
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(15)
            .padding()  
    }
}
