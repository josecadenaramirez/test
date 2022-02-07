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
//        api_key=d9825b94dae2d9ee89f083795e4f19eb
        let url = "https://api.themoviedb.org/3/\(path)?api_key=d9825b94dae2d9ee89f083795e4f19eb&language=en-US&page=\(page)"
        ApiManager.shared.request(method: .get, urlStr: url) { (data, response, error) in
            print("respone\(response)")
            print("errrrrro\(error)")
            if let data = data{
                let str = String(decoding: data, as: UTF8.self)
                print("data\(str)")
                do{
                    let tokenInfo = try JSONDecoder().decode(Movies.self, from: data)
                    completion(tokenInfo)
                }catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
            }else{
                completion(nil)
            }
        }
    }
}
