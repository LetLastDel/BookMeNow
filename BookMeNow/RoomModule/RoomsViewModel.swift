//
//  RoomsViewModel.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 1.09.2023.
//

import Foundation

class RoomsViewModel: ObservableObject {
    @Published var rooms: RoomsModel?
    @Published var loaded = false
    
    init(){
        getRooms(endPoint: EndPoint.room)
    }
    
    func getRooms(endPoint: EndPoint) {
        Task{
            let motelInfo =  try await NetworkService.shared.getData(endPoint: endPoint) as RoomsModel
            DispatchQueue.main.async {
                self.rooms = motelInfo
                self.loaded.toggle()
            }
        }
    }
}
