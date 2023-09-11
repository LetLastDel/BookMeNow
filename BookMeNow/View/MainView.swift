//
//  MainView.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 31.08.2023.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    @State var showNextView = false
    var body: some View {
        
        VStack{
            if let hotel = viewModel.hotel{
                Text("Отель")
                    .font(Fonts.customFontMedium18px)
                ScrollView(.vertical, showsIndicators: false){
                    VStack(alignment: .leading, spacing: 15){
                        ImageGallery(urls: hotel.imageUrls)
                        HoratingStackExt(horating: hotel.rating , horatingName: hotel.ratingName)
                        VStack(alignment: .leading){
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
                    }
                    .padding(.horizontal, 16)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .cornerRadius(10)
                    .padding(.vertical, 1)
                    VStack{
                        VStack(alignment: .leading){
                            Text("Об отеле")
                                .font(Fonts.customFontHeavy22px)
                            FlexibleView(data: hotel.aboutTheHotel.peculiarities) { pecul in
                                PeculiaritiesHStaclExt(text: pecul)
                            }
                            Text(hotel.aboutTheHotel.description)
                                .font(Fonts.customFontRegular16px)
                        }.padding(.horizontal, 13)
                        VStack(spacing: -4){
                            ForEach(0..<viewModel.buttons.count) { index in
                                let isLastItem = (index == viewModel.buttons.count - 1)
                                ButtonExt(text: viewModel.buttons[index].0, image: viewModel.buttons[index].1, showDivider: !isLastItem)
                            }
                        }.cornerRadius(10)
                            .padding()
                    }
                    .background(.white)
                    .cornerRadius(15)
                    .padding(.vertical, 1)
                }
                VStack{
                    BlueButtonExt(action: {showNextView.toggle()},text: "К выбору номера")
                }.fullScreenCover(isPresented: $showNextView, content: {
                    NavigationView {
                        RoomView(hotel: hotel)
                    }
                })
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
        MainView()
    }
}
