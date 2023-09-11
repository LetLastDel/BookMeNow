//
//  ContentView.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 11.09.2023.
//

import SwiftUI

struct CoordinatorView: View {
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.navPath) {
            coordinator.getView(ViewEnum.main)
                .navigationDestination(for: ViewEnum.self) { view in
                    coordinator.getView(view)
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CoordinatorView()
            .environmentObject(Coordinator())
    }
}
