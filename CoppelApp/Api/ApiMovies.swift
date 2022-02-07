//
//  ApiMovies.swift
//  CoppelApp
//
//  Created by Jose Cadena on 06/02/22.
//

import Foundation
extension ApiManager{
    func getMovies(optionSelected:Int = 0, page: Int = 1, completion: @escaping (Movies?) -> Void){
        var path = ""
        switch optionSelected {
        case 0:
            path = "movie/popular"
        case 1:
            path = "movie/top_rated"
        case 2:
            path = "movie/now_playing"
        case 3:
            path = "movie/upcoming"
        default:
            break
        }
        let url = "\(TargetEnvironment.URL_ENDPOINT)/\(path)?api_key=\(TargetEnvironment.BASIC_KEY)&language=en-US&page=\(page)"
        ApiManager.shared.request(method: .get, urlStr: url) { (data, response, error) in
            if let data = data{
                do{
                    let tokenInfo = try JSONDecoder().decode(Movies.self, from: data)
                    completion(tokenInfo)
                } catch {
                    print("error: ", error)
                }
            }else{
                completion(nil)
            }
        }
    }
}
