//
//  NetworkService.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 1.09.2023.
//

import Foundation
import UIKit


class NetworkService{
    static let shared = NetworkService(); private init() { }
    
    func getData<T: Decodable>(endPoint: EndPoint) async throws -> T {
        guard let url = URLManager.shared.createUrl(endPoint: endPoint) else { throw NetworkError.badUrl}
        do{
            let responce = try await URLSession.shared.data(from: url)
            let data = responce.0
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do{
                let fetch = try decoder.decode(T.self, from: data)
                return fetch
            } catch {
                throw NetworkError.invalidDecoding
            }
        } catch {
            throw NetworkError.badResponse
        }
    }

    func dwImage(url: String) async throws -> UIImage? {
        guard let url = URL(string: url) else { return nil }
        do {
            let responce = try await URLSession.shared.data(from: url)
            let data = responce.0
            guard let image = UIImage(data: data) else {
                return nil
            }
            return image
        } catch {
            return nil
        }
    }
}

