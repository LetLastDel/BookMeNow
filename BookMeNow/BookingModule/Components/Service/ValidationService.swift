//
//  ValidationService.swift
//  BookMeNow
//
//  Created by A.Stelmakh on 13.09.2023.
//

import Foundation
import Combine


class ValidationService: ObservableObject {
    @Published var number: String = ""
    @Published var email: String = ""
    @Published var canPush = false
    @Published private var isValidEmail = false
    @Published private var isValidNumber = false
    private let numberPredicate = NSPredicate(format: "SELF MATCHES %@", Regex.phone.rawValue)
    private let emailPredicate = NSPredicate(format: "SELF MATCHES %@",  Regex.email.rawValue)
    private var cancellable: Set<AnyCancellable> = []
    var emailError: Bool { return !email.isEmpty && !isValidEmail }
    var phoneError: Bool { return !number.isEmpty && !isValidNumber }


    func isValidEmail(_ email: String) -> Bool {
        return emailPredicate.evaluate(with: email)
    }

    func isValidPhoneNumber(_ number: String) -> Bool {
        return numberPredicate.evaluate(with: number)
    }
    
    func validate(){
        $email
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map{ email in
                return self.emailPredicate.evaluate(with: email)
            }
            .assign(to: \.isValidEmail, on: self)
            .store(in: &cancellable)
        $number
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map{ number in
                return self.numberPredicate.evaluate(with: number)
            }
            .assign(to: \.isValidNumber, on: self)
            .store(in: &cancellable)
        
        Publishers.CombineLatest($isValidEmail, $isValidNumber)
            .map { email, number in
                return (email && number)
            }
            .assign(to: \.canPush, on: self)
            .store(in: &cancellable)
    }
    
    func formatPhoneNumber() -> String {
        var formatNum = "+7"
        let digits = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var currentIndex = 0
        for char in "(***) ***-**-**" {
            if char == "*" {
                if currentIndex < digits.count {
                    formatNum.append(digits[digits.index(digits.startIndex, offsetBy: currentIndex)])
                    currentIndex += 1
                } else {
                    formatNum.append("*")
                }
            } else {
                formatNum.append(char)
            }
        }
        return formatNum
    }
}
