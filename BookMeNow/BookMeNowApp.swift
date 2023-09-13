//
//  BookMeNowApp.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 31.08.2023.
//

import SwiftUI

@main
struct BookMeNowApp: App {
    var body: some Scene {
        WindowGroup {
                CoordinatorView()
                .environmentObject(Coordinator())
            }
        }
}
