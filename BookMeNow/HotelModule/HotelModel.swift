//
//  HotelModel.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 1.09.2023.
//

import Foundation

struct HotelModel: Decodable, Identifiable {
    var id: Int
    var name: String
    var adress: String
    var minimalPrice: Int
    var priceForIt: String
    var rating: Int
    var ratingName: String
    var imageUrls: [String]
    var aboutTheHotel: AboutTheHotel
    
    struct AboutTheHotel: Decodable {
        var description: String
        var peculiarities: [String]
    }
}

private enum CodingKeys: String, CodingKey {
    case id, name, adress, minimalPrice = "minimal_price", priceForIt = "price_for_it", rating, ratingName = "rating_name", imageUrls = "image_urls", aboutTheHotel = "about_the_hotel"
}
