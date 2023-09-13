//
//  ImageExt.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 2.09.2023.
//

import Foundation
import SwiftUI

extension Image{
        func resizeImg() -> some View {
            self
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 10)
        }
    }

