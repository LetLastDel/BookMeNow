//
//  URLManager.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 1.09.2023.
//

import Foundation

class URLManager{
    static let shared = URLManager(); private init() { }
    private let tunnel = "https://"
    private let server = "run.mocky.io/v3/"
    
    func createUrl(endPoint: EndPoint) -> URL? {
        let str = tunnel + server + endPoint.rawValue
        let url = URL(string: str)
        return url
    }
}
enum EndPoint: String{
    case motel = "35e0d18e-2521-4f1b-a575-f0fe366f66e3"
    case room = "f9a38183-6f95-43aa-853a-9c83cbb05ecd"
    case booking = "e8868481-743f-4eb2-a0d7-2bc4012275c8"
}
