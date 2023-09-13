//
//  BookingInfoView.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 12.09.2023.
//

import SwiftUI

struct BookingInfoView: View {
    var viewModel: BookingViewModel

    var body: some View {
        VStack(alignment: .leading){
            HoratingStackExt(horating: viewModel.booking?.horating ?? 0, horatingName: viewModel.booking?.ratingName ?? "")
            VStack(alignment: .leading){
                Text(viewModel.booking?.hotelName ?? "")
                    .font(Fonts.customFontHeavy22px)
                Button(viewModel.booking?.hotelAdress ?? "") {
                    print("Нажата кнопка с адрессом")
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .font(Fonts.customFontRegular14px)
            }
        }
        .padding()
        .background(.white)
        .cornerRadius(10)
        DataStackExt(data: viewModel.bookingData, spacer: false)
    }
}

