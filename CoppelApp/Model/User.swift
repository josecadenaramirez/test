//
//  User.swift
//  CoppelApp
//
//  Created by Jose Cadena on 04/02/22.
//

import Foundation
struct User: Codable {
    var name:String?
    var id:Int?
}

struct UserCredentials: Codable {
    var username:String
    var password: String
}
