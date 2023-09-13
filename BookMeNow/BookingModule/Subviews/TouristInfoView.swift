//
//  TouristInfoView.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 12.09.2023.
//

import SwiftUI

struct TouristInfoView: View {
    @ObservedObject var viewModel: BookingViewModel
    @ObservedObject var validation: ValidationService
    @Binding var pushedPhoneTF: Bool
    @Binding var paymentButtonPressed: Bool
    
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                Text("Информация о покупателе")
                    .font(Fonts.customFontHeavy22px)
                ZStack(alignment: .leadingLastTextBaseline) {
                    TextFieldExt(fieldName: "Номер телефона", text: $validation.number, promt: validation.phoneError, paymentButtonPressed: paymentButtonPressed)
                        .keyboardType(.numberPad)
                        .foregroundColor(.clear)
                        .onChange(of: validation.number) { newValue in
                            DispatchQueue.main.async {
                                validation.number = validation.number.formattedMask(text: validation.number, mask: "    (XXX) XXX-XX-XX")
                            }
                        }
                        .onTapGesture {
                            pushedPhoneTF = true
                        }
                    if pushedPhoneTF{
                        Text(validation.formatPhoneNumber()).padding()
                            .allowsHitTesting(false)
                    }
                }
                TextFieldExt(fieldName: "Почта", text: $validation.email, promt: validation.emailError, paymentButtonPressed: paymentButtonPressed)
                Text("Эти данные никому не передаются. После оплаты мы вышлем чек на указанный Вами номер и почту")
                    .font(Fonts.customFontRegular14px)
                    .foregroundColor(.gray)
            }.padding()
        }
        .background(.white)
        .cornerRadius(10)
    }
}

