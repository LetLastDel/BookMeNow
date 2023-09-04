//
//  PaidView.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 1.09.2023.
//

import SwiftUI

struct PaidView: View {
    let randomNumber = Int.random(in: 1000...9000)
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack{
            TopBarStack(title: "Заказ оплачен", presentationMode: presentationMode)
            Spacer()
            Image("paid")
            Text("Ваш заказ принят в работу")
                .font(Font.custom("SF Pro Display", size: 22))
            VStack(alignment: .center){
                Text("Подтверждение заказа №\(randomNumber.description) может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление.")
                    .multilineTextAlignment(.center)
                    .font(Font.custom("SF Pro Display", size: 16))
                    .foregroundColor(.gray)

            }
           Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .overlay(alignment: .bottom, content: {
            VStack{
                BlueButtonExt(action: {
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let rootViewController = windowScene.windows.first?.rootViewController {
                        rootViewController.dismiss(animated: true, completion: nil)
                    }
                }, text: "Cупер!")

            }
            .ignoresSafeArea()
            .background(.white)
        })
    }
}

struct PaidView_Previews: PreviewProvider {
    static var previews: some View {
        PaidView()
    }
}
