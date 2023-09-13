//
//  TouristListView.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 12.09.2023.
//

import SwiftUI

struct TouristListView: View {
    @ObservedObject var viewModel: BookingViewModel
    @Binding var paymentButtonPressed: Bool
    var maxTouristCount: Bool
    
    var body: some View {
        ForEach(viewModel.tourist.indices, id: \.self) { index in
            TouristStackExt(
                tourist:$viewModel.tourist[index], index: index,
                paymentButtonPressed: paymentButtonPressed)
        }
        HStack{
            Text(maxTouristCount ? "Добавить туриста" : "Максимальное количетсво туристов")
                .font(Fonts.customFontHeavy22px)
                .padding()
            Spacer()
            Button {
                if maxTouristCount {
                    viewModel.tourist.append(TouristModel())
                }
            } label: {
                Image("plusButton")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32)
            }.padding()
        }
        .background(.white)
    }
}

