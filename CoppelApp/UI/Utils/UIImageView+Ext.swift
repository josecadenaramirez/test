//
//  UIImageView+Ext.swift
//  CoppelApp
//
//  Created by Jose Cadena on 06/02/22.
//

import UIKit

extension UIImageView{
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            self.image = nil
            DispatchQueue.main.async() { [weak self] in
                UIView.animate(withDuration: 0.20) {
                    self?.image = UIImage(data: data)
                }
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
