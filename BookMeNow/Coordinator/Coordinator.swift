//
//  Coordinator.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 11.09.2023.
//

import Foundation
import SwiftUI

@MainActor
final class Coordinator: ObservableObject {
    @Published var navPath = NavigationPath()
    @Published var view: ViewEnum = .main
    @Published var hotel: HotelModel?
    
    func goBackMain () {
        navPath.removeLast(navPath.count)
    }
    
    func showRoomView (hotel: HotelModel) {
        self.hotel = hotel
        navPath.append(ViewEnum.room)
    }
    
    func showBookingView () {
        navPath.append(ViewEnum.booking)
    }
    
    func showPaidView () {
        navPath.append(ViewEnum.paid)
    }
    
    @ViewBuilder
    func getView (_ page: ViewEnum) -> some View {
        switch page {
        case .main:
            HotelView()
        case .room:
            RoomView(hotel: hotel)
        case .booking:
            BookingView()
        case .paid:
            PaidView()
        }
    }
}


