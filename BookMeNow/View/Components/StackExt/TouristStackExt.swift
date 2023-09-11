//
//  TouristStackExt.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 31.08.2023.
//
import SwiftUI

struct TouristStackExt: View {
    @Binding var tourist: TouristModel
    var index: Int
    @State var pushed = false
    var paymentButtonPressed: Bool

    @State private var birthTap = false
    @State private var birthDate = Date()
    @State private var passportTap = false
    @State private var passportDate = Date()
    
    var dictiontary = [0: "Первый",
                       1:"Второй",
                       2:"Третий",
                       3:"Четвертый",
                       4:"Пятый"]
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("\(dictiontary[index] ?? "") турист")
                        .font(Fonts.customFontHeavy22px)
                    Spacer()
                    Button {
                        withAnimation {
                            self.pushed.toggle()
                        }
                    } label: {
                        Image(pushed ? "arrowButton" : "arrowButton")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 32)
                            .rotationEffect(Angle(degrees: pushed ? 180 : 0))
                    }
                }.padding()
                if pushed {
                    VStack {
                        TextFieldExt(fieldName: "Имя", text: $tourist.name, paymentButtonPressed: paymentButtonPressed)
                        TextFieldExt(fieldName: "Фамилия", text: $tourist.surname, paymentButtonPressed: paymentButtonPressed)
                        TextFieldExt(fieldName: "Дата рождения", text: $tourist.birthDate, paymentButtonPressed: paymentButtonPressed)
                            .onTapGesture {
                                    self.birthTap.toggle()
                            }
                            .sheet(isPresented: $birthTap) {
                                KeyboardExt(taped: $birthTap, date: $birthDate, text: $tourist.birthDate)
                            }
                        TextFieldExt(fieldName: "Гражданство", text: $tourist.nationality, paymentButtonPressed: paymentButtonPressed)
                        TextFieldExt(fieldName: "Номер загранпаспорта", text: $tourist.passport, paymentButtonPressed: paymentButtonPressed)
                            .keyboardType(.numberPad)
                            .onChange(of: tourist.passport) { newValue in
                                DispatchQueue.main.async {
                                    tourist.passport = tourist.passport.formattedMask(text: tourist.passport,  mask: "XX XXXXXXX")
                                }
                            }
                        TextFieldExt(fieldName: "Срок действия загранпаспорта", text: $tourist.exp, paymentButtonPressed: paymentButtonPressed)
                            .onTapGesture {
                                    self.passportTap.toggle()
                            }
                            .sheet(isPresented: $passportTap) {
                                KeyboardExt(taped: $passportTap, date: $passportDate, text: $tourist.exp)
                            }
                    }.padding()
                }
            }
            .background(.white)
            .cornerRadius(10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
