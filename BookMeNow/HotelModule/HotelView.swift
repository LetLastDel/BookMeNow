//
//  MainView.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 31.08.2023.
//

import SwiftUI

struct HotelView: View {
    @StateObject var viewModel = HotelViewModel()
    @EnvironmentObject var coordinator: Coordinator

    var body: some View {
            VStack{
                if let hotel = viewModel.hotel{
                    Text("Отель")
                        .font(Fonts.customFontMedium18px)
                    ScrollView(.vertical, showsIndicators: false){
                            VStack(alignment: .leading){
                                ImageGallery(urls: hotel.imageUrls)
                                HoratingStackExt(horating: hotel.rating , horatingName: hotel.ratingName)
                                Text(hotel.name)
                                    .font(Fonts.customFontHeavy22px)
                                Button(hotel.adress) {
                                    print("Нажата кнопка с адрессом")
                                }.frame(maxWidth: .infinity, alignment: .leading)
                                    .font(Fonts.customFontRegular14px)
                                Spacer(minLength: 10)
                                HStack{
                                    Text("от")
                                        .font(Fonts.customFontHeavy30px)
                                    Text(String.formatCurrency(value: hotel.minimalPrice))
                                        .font(Fonts.customFontHeavy30px)
                                    Text(hotel.priceForIt)
                                        .font(Fonts.customFontRegular16px)
                                        .foregroundColor(.gray)
                                }
                            }
                        .padding()
                        .background(.white)
                        .cornerRadius(10)
                        VStack{
                            HStack{
                                VStack(alignment: .leading){
                                    Text("Об отеле")
                                        .font(Fonts.customFontHeavy22px)
                                    FlexibleView(data: hotel.aboutTheHotel.peculiarities) { pecul in
                                        PeculiaritiesHStaclExt(text: pecul)
                                    }
                                    Text(hotel.aboutTheHotel.description)
                                        .font(Fonts.customFontRegular16px)
                                }
                                Spacer()
                            }
                            VStack(spacing: -4){
                                ForEach(0..<viewModel.buttons.count) { index in
                                    let isLastItem = (index == viewModel.buttons.count - 1)
                                    ButtonExt(text: viewModel.buttons[index].0, image: viewModel.buttons[index].1, showDivider: !isLastItem)
                                }
                            }.cornerRadius(10)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.white)
                        .cornerRadius(10)
                    }
                    VStack {
                        BlueButtonExt(action: { coordinator.showRoomView(hotel: hotel) }, text: "К выбору номера")
                    }
                    .background(.white)
                } else {
                    ProgressView()
                }
            }
            .background(.gray.opacity(0.05))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        HotelView()
    }
}
