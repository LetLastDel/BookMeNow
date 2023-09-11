//
//  RoomCell.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 31.08.2023.
//

import SwiftUI

struct RoomCell: View {
    var room: RoomsModel.Rooms    
    @State var showBookingView = false
    @EnvironmentObject var coordinator: Coordinator

    var body: some View {
        VStack(alignment: .leading){
            ImageGallery(urls: room.imageUrls)
            Text(room.name)
                .font(Fonts.customFontHeavy22px)
            FlexibleView(data: room.peculiarities) { pecul in
                PeculiaritiesHStaclExt(text: pecul)
            }
            Button("Подробнее о номере >") {
                print("Нажал подробнее о номере")
            }
            .font(Fonts.customFontRegular16px)
            .buttonStyle(PlainButtonStyle())
            .foregroundColor(.blue)
            .padding(6)
            .background(.blue.opacity(0.15))
            .cornerRadius(5)
            VStack(spacing: 0){
                HStack(alignment: .bottom){
                    Text(String.formatCurrency(value: room.price))
                        .font(Fonts.customFontHeavy30px)
                    Text(room.pricePer)
                        .font(Fonts.customFontRegular16px)
                        .foregroundColor(.gray)
                }.padding(.trailing, 30)
                BlueButtonExt(action: {coordinator.showBookingView()}, text: "Выбрать номер")
                        .shadow(color: .blue, radius: 0, x: 16, y: 0)
                        .shadow(color: .blue, radius: 0, x: -16, y: 0)
                        .shadow(color: .blue, radius: 0, x: 0, y: 5)
                        .shadow(color: .blue, radius: 0, x: 0, y: -5)
                        .buttonStyle(PlainButtonStyle())
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(.white)
        .cornerRadius(20)
    }
}

struct RoomCell_Previews: PreviewProvider {
    static var previews: some View {
        RoomCell(room: RoomsModel.Rooms(id: 1, name: "Номер с видом на море", price: 121221, pricePer: "за семь ночей", peculiarities: [], imageUrls: []))
    }
}
