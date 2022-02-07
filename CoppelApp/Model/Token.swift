//
//  Token.swift
//  CoppelApp
//
//  Created by Jose Cadena on 05/02/22.
//

import Foundation
struct Token: Codable {
    var success: Bool?
    var expires_at: String?
    var request_token: String?
}
