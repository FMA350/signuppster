//
//  SignUserData.swift
//  signuppster
//
//  Created by Francesco Maria Moneta (BFS EUROPE) on 12/04/2019.
//  Copyright © 2019 wipro.com. All rights reserved.
//

import Foundation

class SignUserData : Codable{
    //class that holds the information that will be saved and retrieved to and from the disk
    var username : String
    var email    : String
    var password : String
    var gender   : Int  //
    
    init(username : String, email : String, password : String, gender : Int) {
        self.username = username
        self.email = email
        self.password = password
        self.gender = gender
    }
}
