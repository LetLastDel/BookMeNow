//
//  BookingViewModel.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 1.09.2023.
//

import Foundation
import Combine

class BookingViewModel: ObservableObject {
    @Published var booking: BookingModel?
    private(set) var prefix = "7"
    @Published var number: String = ""
    @Published var email: String = ""
    @Published var canPush = false
    @Published var tourist: [TouristModel] = []
    @Published private var isValidEmail = false
    @Published private var isValidNumber = false
    private let numberPredicate = NSPredicate(format: "SELF MATCHES %@", Regex.phone.rawValue)
    private let emailPredicate = NSPredicate(format: "SELF MATCHES %@",  Regex.email.rawValue)
    private var cancellable: Set<AnyCancellable> = []

    var emailError: Bool{
        if email.isEmpty || isValidEmail == true {
            return false
        } else {
            return true
        }
    }
    
    var phoneError: Bool{
        if number.isEmpty || isValidNumber == true{
            return false
        } else {
            return true
        }
    }
    
init(){
    tourist.append(TouristModel())
    getBooking(endPoint: EndPoint.booking)
    $email
        .debounce(for: 0.5, scheduler: RunLoop.main)
        .map{ email in
            return self.emailPredicate.evaluate(with: email)
        }
        .assign(to: \.isValidEmail, on: self)
        .store(in: &cancellable)
    $number
        .debounce(for: 0.5, scheduler: RunLoop.main)
        .map{ number in
            return self.numberPredicate.evaluate(with: number)
        }
        .assign(to: \.isValidNumber, on: self)
        .store(in: &cancellable)
    
    Publishers.CombineLatest($isValidEmail, $isValidNumber)
        .map { email, number in
            return (email && number)
        }
        .assign(to: \.canPush, on: self)
        .store(in: &cancellable)
}

func getBooking(endPoint: EndPoint) {
    Task{
       let motelInfo =  try await NetworkService.shared.getData(endPoint: endPoint) as BookingModel
        DispatchQueue.main.async {
            self.booking = motelInfo
        }
    }
}
    
    func areAllFieldsFilled() -> Bool {
        if number.isEmpty || email.isEmpty {
            return false
        }
        for tourist in tourist {
            if tourist.name.isEmpty || tourist.surname.isEmpty ||
               tourist.birthDate.isEmpty || tourist.nationality.isEmpty ||
               tourist.passport.isEmpty || tourist.exp.isEmpty {
                return false
            }
        }
        return true
    }
    
    func formatPhoneNumber() -> String {
        var formatNum = ""
        let digits = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var currentIndex = 0
        for char in "+*(***) ***-**-**" {
            if char == "*" {
                if currentIndex < digits.count {
                    formatNum.append(digits[digits.index(digits.startIndex, offsetBy: currentIndex)])
                    currentIndex += 1
                } else {
                    formatNum.append("*")
                }
            } else {
                formatNum.append(char)
            }
        }
        return formatNum
    }
    
    func calculateFinalSum() -> String?{
        guard let booking else { return nil }
        let sum = booking.tourPrice + booking.serviceCharge + booking.fuelCharge
        return String.formatCurrency(value:sum)
    }
    
    lazy var bookingData: [(String, String?)] = [
        ("Вылет из", self.booking?.departure),
        ("Страна, город", booking?.arrivalCountry),
        ("Даты", "\(booking?.tourDateStart ?? "") - \(booking?.tourDateStop ?? "")"),
        ("Кол-во ночей", String(booking?.numberOfNights ?? 0) + " ночей"),
        ("Отель", booking?.hotelName),
        ("Номер", booking?.room),
        ("Питание", booking?.nutrition)]
    
    lazy var priceData: [(String, String?)] = [
        ("Тур", String.formatCurrency(value: booking?.tourPrice ?? 0)),
        ("Топливный сбор", String.formatCurrency(value: booking?.fuelCharge ?? 0)),
        ("Сервисный сбор", String.formatCurrency(value: booking?.serviceCharge ?? 0)),
        ("К оплате", calculateFinalSum())]
  }
