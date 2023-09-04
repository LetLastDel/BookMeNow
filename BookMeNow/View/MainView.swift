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
                    .font(Font.custom("SF Pro Display", size: 18).weight(.medium))
                ScrollView(.vertical, showsIndicators: false){
                    VStack(alignment: .leading, spacing: 15){
                        ImageGallery(urls: hotel.imageUrls )
                        HoratingStackExt(horating: hotel.rating , horatingName: hotel.ratingName)
                        VStack(alignment: .leading){
                            Text(hotel.name)
                                .font(Font.custom("SF Pro Display", size: 22).weight(.bold))
                            Button(hotel.adress) {
                                print("Нажата кнопка с адрессом")
                            }.frame(maxWidth: .infinity, alignment: .leading)
                                .font(Font.custom("SF Pro Display", size: 14))
                            Spacer(minLength: 10)
                            HStack{
                                Text("от")
                                    .font(Font.custom("SF Pro Display", size: 30).weight(.bold))
                                Text(String.formatCurrency(value: hotel.minimalPrice))
                                    .font(Font.custom("SF Pro Display", size: 30).weight(.bold))
                                Text(hotel.priceForIt)
                                    .font(Font.custom("SF Pro Display", size: 16))
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
                                .font(Font.custom("SF Pro Display", size: 22).weight(.bold))
                            PeculiaritiesStackExt(peculiarities: hotel.aboutTheHotel.peculiarities)
                            Text(hotel.aboutTheHotel.description)
                                .font(Font.custom("SF Pro Display", size: 16).weight(.bold))

                        }.padding(.horizontal, 13)
                        VStack(spacing: -4){
                            ForEach(0..<viewModel.buttons.count) { text in
                                ButtonExt(text: viewModel.buttons[text].0, image: viewModel.buttons[text].1)
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
