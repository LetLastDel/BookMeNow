//
//  ErrorEnum.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 1.09.2023.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case badResponse
    case invalidDecoding
    case invalidImageData
}
