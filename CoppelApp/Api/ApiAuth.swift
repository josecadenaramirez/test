//
//  ApiLogin.swift
//  CoppelApp
//
//  Created by Jose Cadena on 04/02/22.
//

import Foundation

extension ApiManager{
    func getToken(completion: @escaping (Token?) -> Void){
        let url = "\(TargetEnvironment.URL_ENDPOINT)/authentication/token/new?api_key=\(TargetEnvironment.BASIC_KEY)"
        ApiManager.shared.request(method: .get, urlStr: url) { (data, response, error) in
            if let data = data{
                do{
                    let tokenInfo = try JSONDecoder().decode(Token.self, from: data)
                    completion(tokenInfo)
                } catch {
                    print("error: ", error)
                }
            }else{
                completion(nil)
            }
        }
    }
    
    func login(user info: UserCredentials, completion: @escaping (Token?) -> Void){
        var configDictionary = try! info.asDictionary()
        configDictionary["request_token"] = UserInfo.shared.token ?? ""
        let url = "\(TargetEnvironment.URL_ENDPOINT)/authentication/token/validate_with_login?api_key=\(TargetEnvironment.BASIC_KEY)"
        ApiManager.shared.request(method: .post, urlStr: url, body: configDictionary) { (data, response, error) in
            if let data = data{
                do{
                    let token = try JSONDecoder().decode(Token.self, from: data)
                    completion(token)
                } catch {
                    print("error: ", error)
                }
            }else{
                completion(nil)
            }
        }
    }
}
