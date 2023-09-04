//
//  BookingModel.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 1.09.2023.
//

import Foundation

struct BookingModel: Decodable, Identifiable{
    var id: Int
    var hotelName: String
    var hotelAdress: String
    var horating: Int
    var ratingName: String
    var departure: String
    var arrivalCountry: String
    var tourDateStart: String
    var tourDateStop: String
    var numberOfNights: Int
    var nutrition: String
    var room: String
    var tourPrice: Int
    var fuelCharge: Int
    var serviceCharge: Int
}
private enum CodingKeys: String, CodingKey {
case id, hotelName = "hotel_name", hotelAdress = "hotel_adress", horating, ratingName = "rating_name", departure, arrivalCountry = "arrival_country", tourDateStart = "tour_date_start", tourDateStop = "tour_date_stop", numberOfNights = "number_of_nights",nutrition, room, tourPrice = "tour_price", fuelCharge = "fuel_charge", serviceCharge = "service_charge"
}

