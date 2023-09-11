//
//  BookingView.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 31.08.2023.
//

import SwiftUI

struct BookingView: View {
    @StateObject var viewModel = BookingViewModel()
    @EnvironmentObject var coordinator: Coordinator
    @State private var paymentButtonPressed = false
    @State var pushedPhoneTF = false
    private var maxTouristCount: Bool { viewModel.tourist.count >= 5 ? false : true }
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            TopBarStack(title: "Бронирование", presentationMode: presentationMode)
            if viewModel.booking != nil {
                ScrollView(.vertical, showsIndicators: false) {
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
                    VStack{
                        VStack(alignment: .leading){
                            Text("Информация о покупателе")
                                .font(Fonts.customFontHeavy22px)
                            ZStack(alignment: .leadingLastTextBaseline) {
                                TextFieldExt(fieldName: "Номер телефона", text: $viewModel.number, promt: viewModel.phoneError, paymentButtonPressed: paymentButtonPressed)
                                    .keyboardType(.numberPad)
                                    .foregroundColor(.clear)
                                    .onChange(of: viewModel.number) { newValue in
                                        DispatchQueue.main.async {
                                            viewModel.number = viewModel.number.formattedMask(text: viewModel.number, mask: "+X (XXX) XXX-XX-XX")
                                        }
                                    }
                                    .onTapGesture {
                                        viewModel.number = viewModel.prefix + viewModel.number
                                        pushedPhoneTF = true
                                    }
                                if pushedPhoneTF{
                                    Text(viewModel.formatPhoneNumber()).padding()
                                        .allowsHitTesting(false)
                                }
                            }
                            TextFieldExt(fieldName: "Почта", text: $viewModel.email, promt: viewModel.emailError, paymentButtonPressed: paymentButtonPressed)
                            Text("Эти данные никому не передаются. После оплаты мы вышлем чек на указанный Вами номер и почту")
                                .font(Fonts.customFontRegular14px)
                                .foregroundColor(.gray)
                        }.padding()
                    }
                    .background(.white)
                    .cornerRadius(10)
                    VStack(spacing: 10){
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
                    .cornerRadius(10)
                    DataStackExt(data: viewModel.priceData, spacer: true)
                    Spacer()
                        .background(.white)
                        .cornerRadius(10)
                        .padding(.vertical, 10)
                }
                .overlay(alignment: .bottom, content: {
                    VStack{
                        BlueButtonExt(action:{
                            paymentButtonPressed = true
                                 if viewModel.areAllFieldsFilled(){
                            coordinator.showPaidView()
                                }
                        }, text: "Оплатить")
                    }
                    .ignoresSafeArea()
                    .background(.white)
                })
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.gray.opacity(0.05))
            } else {
                Spacer()
                ProgressView()
                Spacer()
            }
        }        .onTapGesture {
            hideKeyboard()
        }
        .navigationBarBackButtonHidden(true)
    }
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()
    }
}

