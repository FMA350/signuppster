//
//  File.swift
//  signuppster
//
//  Created by Francesco Maria Moneta (BFS EUROPE) on 11/04/2019.
//  Copyright © 2019 wipro.com. All rights reserved.

import Foundation
import UIKit

protocol ValidatorConvertible {
    func validated(_ value: String?) -> (Bool, String?)
}


enum ValidatorType {
    case email
    case password
    case username
    case initDefault
}

enum VaildatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
            case .email: return EmailValidator()
            case .password: return PasswordValidator()
            case .username: return UserNameValidator()
            case .initDefault : return InitDefaultValidator()
        }
    }
}

extension UITextField {
    func validatedText(validationType: ValidatorType) -> (Bool, String?) {
        let validator = VaildatorFactory.validatorFor(type: validationType)
        return validator.validated(self.text!)
    }
}

struct EmailValidator : ValidatorConvertible{
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"

     func validated(_ value: String?) -> (Bool, String?){
        if let value = value{
            //if length is zero
            if (value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty){
                return (false, "Email is empty")
            }
            //check if email is a single word
            let whitespace = NSCharacterSet.whitespaces
            let range = value.rangeOfCharacter(from: whitespace)
            if  range != nil {
                return (false, "Email can only be a single word")
            }
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            if !emailTest.evaluate(with: value){
                return (false, "Email address is invalid")
            }
            //All good!
            return (true, "Email is validated")
        }
        return (false,"Email is absent")
    }
}

struct UserNameValidator : ValidatorConvertible{
    func validated(_ value: String?) -> (Bool, String?) {
        if let value = value{
            if value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                return (false, "Username is empty\n")
            }
            let whitespace = NSCharacterSet.whitespaces
            let range = value.rangeOfCharacter(from: whitespace)
            if  range != nil {
                return (false, "username can only be a single word\n")
            }
            //All good!
            return (true, "Username is validated")
        }
        return (false, "Username is empty")
    }
}

struct PasswordValidator : ValidatorConvertible{
    func validated(_ value: String?) -> (Bool, String?) {
        if let value = value{
            let hasNumerics = value.rangeOfCharacter(from : NSCharacterSet.decimalDigits)
            let hasCapital =  value.rangeOfCharacter(from : NSCharacterSet.capitalizedLetters)
            
            if value.count < 6{
                return (false, "Password is too short\n")
            }
            var passwordValue = value.count
            if hasNumerics != nil{
                passwordValue+=5
            }
            if hasCapital != nil{
                passwordValue+=5
            }
            
            if passwordValue > 20 {
                return (true, "strong")
            }
            if passwordValue > 12 {
                return (true, "average")
            }
            else {
                return (true, "weak")
            }
        }
    return (false, "Password is not present\n")
    }
}

struct InitDefaultValidator : ValidatorConvertible{
    func validated(_ value: String?) -> (Bool, String?) {
        return (true, "No validation")
    }
}





