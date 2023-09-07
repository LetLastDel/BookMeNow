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
    var dictiontary = [0: "Первый",
                       1:"Второй",
                       2:"Третий",
                       3:"Четвертый",
                       4:"Пятый"]
    
    @State var isValidName = false
    @State var isValidSurname = false
    @State var isValidBirthDate = false
    @State var isValidNationality = false
    @State var isValidPassport = false
    @State var isValidExp = false

    
    
    
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("\(dictiontary[index] ?? "") турист")
                        .font(Font.custom("SF Pro Display", size: 22))
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
                            .keyboardType(.numberPad)
                            .onChange(of: tourist.birthDate) { newValue in
                                DispatchQueue.main.async {
                                    tourist.birthDate = tourist.birthDate.formattedMask(text: tourist.birthDate,  mask: "XX.XX.XXXX")
                                }
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
                            .keyboardType(.numberPad)
                            .onChange(of: tourist.exp) { newValue in
                                DispatchQueue.main.async {
                                    tourist.exp = tourist.exp.formattedMask(text: tourist.exp,  mask: "XX.XX.XXXX")
                                }
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
//    .onChange(of: viewModel.number) { newValue in
//        let formattedNumber = newValue.hasPrefix("+7") ? newValue : "+7" + newValue
//        viewModel.number = formattedNumber.phoneMask(text: formattedNumber, mask: "+x (xxx) xxx-xx-xx")
//    }
