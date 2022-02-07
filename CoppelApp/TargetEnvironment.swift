//
//  TargetEnvironment.swift
//  CoppelApp
//
//  Created by Jose Cadena on 07/02/22.
//


import Foundation

public enum TargetEnvironment {
    // MARK: - Keys
    enum Keys {
        enum Plist {
            static let urlEndpoint = "URL_ENDPOINT"
            static let basicKey = "BASIC_KEY"
            static let urlMedia = "URL_MEDIA"
        }
    }
    
    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    static let URL_ENDPOINT: String = {
        guard let endpoint = TargetEnvironment.infoDictionary[Keys.Plist.urlEndpoint] as? String else {
            fatalError("endpoint not set in plist for this environment")
        }
        return endpoint
    }()
    
    static let BASIC_KEY: String = {
        guard let endpoint = TargetEnvironment.infoDictionary[Keys.Plist.basicKey] as? String else {
            fatalError("endpoint not set in plist for this environment")
        }
        return endpoint
    }()
    
    static let URL_MEDIA: String = {
        guard let endpoint = TargetEnvironment.infoDictionary[Keys.Plist.urlMedia] as? String else {
            fatalError("endpoint not set in plist for this environment")
        }
        return endpoint
    }()
}
