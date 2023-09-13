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
    var maxTouristCount: Bool { viewModel.tourist.count >= 5 ? false : true }
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            TopBarStack(title: "Бронирование", presentationMode: presentationMode)
          //  if viewModel.booking != nil {
                ScrollView(.vertical, showsIndicators: false) {
                    BookingInfoView(viewModel: viewModel)
                    TouristInfoView(viewModel: viewModel, validation: viewModel.validationService, pushedPhoneTF: $pushedPhoneTF, paymentButtonPressed: $paymentButtonPressed)
                    TouristListView(viewModel: viewModel, paymentButtonPressed: $paymentButtonPressed, maxTouristCount: maxTouristCount)
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
//            } else {
//                Spacer()
//                ProgressView()
//                Spacer()
//            }
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

