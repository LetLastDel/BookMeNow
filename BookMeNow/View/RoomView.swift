//
//  RoomView.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 31.08.2023.
//

import SwiftUI

struct RoomView: View {
    var hotel: HotelModel
    @StateObject var viewModel = RoomsViewModel()
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        VStack{
            TopBarStack(title: hotel.name, presentationMode: presentationMode)
            if let room = viewModel.rooms?.rooms {
                List{
                    ForEach(0..<room.count, id: \.self) { index in
                        RoomCell(room: room[index])
                    }.shadow(color: .white, radius: 0, x: 20, y: 0)
                        .shadow(color: .white, radius: 0, x: -20, y: 0)
                        .listRowBackground(Color.gray.opacity(0.06))
                        .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)
            } else {
                Spacer()
                ProgressView()
                Spacer()
            }
        }
    }
}
struct RoomView_Previews: PreviewProvider {
    static var previews: some View {
        RoomView(hotel: HotelModel(id: 1, name: "Луночный отель в Хугареы", adress: "", minimalPrice: 1, priceForIt: "", rating: 1, ratingName: "", imageUrls: [], aboutTheHotel: HotelModel.AboutTheHotel(description: "", peculiarities: [])))
    }
}
