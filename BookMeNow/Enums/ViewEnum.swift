//
//  ViewEnum.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 11.09.2023.
//

import Foundation
enum ViewEnum: String, CaseIterable, Identifiable {
    case main
    case room
    case booking
    case paid
    
    var id: String {
        self.rawValue
    }
}
