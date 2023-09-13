//
//  BookingViewModel.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 1.09.2023.
//

import Foundation
import Combine

class BookingViewModel: ObservableObject {
    @Published var validationService = ValidationService()
    @Published var booking: BookingModel?
    @Published var tourist: [TouristModel] = []
    
    init(){
        tourist.append(TouristModel())
        getBooking(endPoint: EndPoint.booking)
        validationService.validate()
    }
    
    func calculateFinalSum() -> String?{
        guard let booking else { return nil }
        let sum = booking.tourPrice + booking.serviceCharge + booking.fuelCharge
        return String.formatCurrency(value:sum)
    }
    
    lazy var bookingData: [(String, String?)] = [
        ("Вылет из", booking?.departure),
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
    
    func areAllFieldsFilled() -> Bool {
        if validationService.number.isEmpty || validationService.email.isEmpty {
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
}

extension BookingViewModel {
    func getBooking(endPoint: EndPoint) {
        Task{
            let motelInfo =  try await NetworkService.shared.getData(endPoint: endPoint) as BookingModel
            DispatchQueue.main.async {
                self.booking = motelInfo
            }
        }
    }
}

