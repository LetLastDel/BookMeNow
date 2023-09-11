//
//  MainViewModel.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 31.08.2023.
//

import Foundation

class HotelViewModel: ObservableObject {
    
    @Published var hotel: HotelModel?
    let buttons = [("Удобства", "smile"), ("Что включено", "ok") ,("Что не включено", "cancel")]

    init(){
        getMotel(endPoint: EndPoint.motel)
    }
    
    func getMotel(endPoint: EndPoint) {
        Task{
           let motelInfo =  try await NetworkService.shared.getData(endPoint: endPoint) as HotelModel
            DispatchQueue.main.async {
                self.hotel = motelInfo
            }
        }
    }
}
