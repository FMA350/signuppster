//
//  ModelController.swift
//  signuppster
//
//  Created by Francesco Maria Moneta (BFS EUROPE) on 12/04/2019.
//  Copyright © 2019 wipro.com. All rights reserved.
//

import Foundation

//static class that handles disk writes

final class IO{
    private init(){
        //this initializer is empty
    }
    
    static func saveUserData(data : SignUserData) throws{
        let defaults = UserDefaults.standard
        let jsonEncoder = JSONEncoder()
        do{
            let jsonData = try jsonEncoder.encode(data)
            defaults.set(jsonData, forKey: data.email)
        }
        catch{
            print(error.localizedDescription)
            throw IOError.encoding
        }
    }
    
   static func saveUserData (username: String, email: String, password: String, gender: Int) throws {
        let defaults = UserDefaults.standard
        let jsonEncoder = JSONEncoder()
        let data : SignUserData = SignUserData(username:username,email:email,password:password,gender:gender)
        do{
            let jsonData = try jsonEncoder.encode(data)
            defaults.set(jsonData, forKey: email)
            
        }
        catch{
            print(error.localizedDescription)
            throw IOError.encoding
        }
        
    
    }
   static func loadUserData(key: String) throws -> SignUserData {
    let defaults = UserDefaults.standard
    let jsonDecoder = JSONDecoder()
        var signUserData : SignUserData
            let jsonData = defaults.data(forKey: key)
            guard let d = jsonData else{
                throw IOError.wrongKey
            }
            signUserData = try jsonDecoder.decode(SignUserData.self, from: d)
        
        return signUserData
    }
}

enum IOError: Error {
    case wrongKey
    case encoding
    case decoding
}
