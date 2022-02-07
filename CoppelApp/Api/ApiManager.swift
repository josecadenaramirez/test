//
//  ApiManager.swift
//  CoppelApp
//
//  Created by Jose Cadena on 04/02/22.
//

import Foundation
import UIKit
import Combine

public typealias responseCompletion = (Data?,URLResponse?, Error?) -> Void
public typealias JSON = [String:Any]

class ApiManager{
    static let shared = ApiManager()
    public let usr = UserDefaults.standard
    public enum httpMethod:String{
        case get    = "GET"
        case post   = "POST"
        case put    = "PUT"
    }
    var anyCancelable = Set<AnyCancellable>()
    private func jsonToData(params:JSON?)->Data?{
        if params != nil{
            let jsonData = try? JSONSerialization.data(withJSONObject: params!)
            return jsonData
        }
        else {return nil}
    }
    
    public func request(vc: UIViewController? = nil, method: httpMethod = .get, urlStr:String, body:JSON? = nil, data:Data? = nil,  headers:[String:String]? = nil, completion: @escaping responseCompletion){
        guard let url = URL(string:urlStr) else {return}
        let urlSession = URLSession(configuration: .default)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpBody = jsonToData(params: body)
        if data != nil {
            urlRequest.httpBody = data
        }
        if !urlStr.contains("files"){
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        if var headers = headers{
            for (key, value) in headers{
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }
        urlRequest.httpMethod = method.rawValue
        let task = urlSession.dataTask(with: urlRequest){data, response, error in
            DispatchQueue.main.async {
                let urlResponse = response as? HTTPURLResponse
                if let code = urlResponse?.statusCode,
                   (200..<300).contains(code){
                    self.handlerSuccess(vc: vc, data, response, error, completion: completion)
                }else{
                    self.handleError(vc: vc, data, response, error, completion: completion)
                }
            }
        }
        task.resume()
    }
    
    private func handleError(vc:UIViewController? = nil, _ data: Data?, _ response:URLResponse?, _ error:Error?, completion: @escaping responseCompletion){
        if let err = error{
        }
        
        completion(data,response,error)
    }
    
    private func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    private func handlerSuccess(vc:UIViewController? = nil, _ data: Data?, _ response:URLResponse?, _ error:Error?, completion: @escaping responseCompletion){
        completion(data,response,error)
    }
}
