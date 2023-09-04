//
//  StringExt.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 1.09.2023.
//

import Foundation

extension String {
        func formattedMask(text: String, mask: String?) -> String {
            let cleanPhoneNumber = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            var result = ""
            var index = cleanPhoneNumber.startIndex
            if let mask = mask {
                for ch in mask where index < cleanPhoneNumber.endIndex {
                    if ch == "X" {
                        result.append(cleanPhoneNumber[index])
                        index = cleanPhoneNumber.index(after: index)
                    } else {
                        result.append(ch)
                    }
                }
            }
            return result
        }
    }
extension String {
    static func formatCurrency(name: String? = "₽", value: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.maximumFractionDigits = 0
        
        let number = NSNumber(value: value)
        let formatVal = formatter.string(from: number) ?? ""
        
        let value = formatVal.enumerated().map { (index, char) in
            return (index > 0 && (formatVal.count - index) % 3 == 0) ? " \(char)" : "\(char)"
        }.joined()

        return "\(value) \(name ?? "₽")"
    }
}








