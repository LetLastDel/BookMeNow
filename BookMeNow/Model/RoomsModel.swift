//
//  RoomsModel.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 1.09.2023.
//

import Foundation

struct RoomsModel: Decodable{
    let rooms: [Rooms]
    
    struct Rooms: Decodable, Identifiable{
        var id: Int
        var name: String
        var price: Int
        var pricePer: String
        var peculiarities: [String]
        var imageUrls: [String]
    }
}

private enum CodingKeys: String, CodingKey {
    case id, name, price, pricePer = "price_per", peculiarities, imageUrls = "image_urls"
}
