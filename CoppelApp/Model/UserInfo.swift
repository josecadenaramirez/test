//
//  UserInfo.swift
//  CoppelApp
//
//  Created by Jose Cadena on 05/02/22.
//

import Foundation
class UserInfo{
    private init() {}
    static let shared = UserInfo()
    private lazy var userdefaults: UserDefaults = .standard
    var token: String?{
        get {
            guard let data = UserDefaults.standard.value(forKey: "token") as? Data else {
            return nil
          }
          return try? JSONDecoder().decode(String.self, from: data)

        }
        set {
          if let encoded = try? JSONEncoder().encode(newValue) {
            UserDefaults.standard.setValue(encoded, forKey: "token")
          }
        }
    }
    var userName: String?{
        get {
            guard let data = UserDefaults.standard.value(forKey: "userName") as? Data else {
            return nil
          }
          return try? JSONDecoder().decode(String.self, from: data)

        }
        set {
          if let encoded = try? JSONEncoder().encode(newValue) {
            UserDefaults.standard.setValue(encoded, forKey: "userName")
          }
        }
    }

}
