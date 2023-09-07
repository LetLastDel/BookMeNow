//
//  KeyboardExt.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 7.09.2023.
//

import SwiftUI

struct KeyboardExt: View {
    @Binding var taped: Bool
    @Binding var date: Date
    @Binding var text: String
    var dateFormatter : DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter}()
    
    var body: some View {
        DatePicker("", selection: $date, displayedComponents: .date)
            .datePickerStyle(.wheel)
            .labelsHidden()
            .onChange(of: date) { newValue in
                text = dateFormatter.string(from: newValue)
            }
            .pickerStyle(.wheel)
            .presentationDetents([.height(200)])
    }
}

//struct KeyboardExt_Previews: PreviewProvider {
//    static var previews: some View {
//        KeyboardExt()
//    }
//}
