//
//  TVCell.swift
//  CoppelApp
//
//  Created by Jose Cadena on 06/02/22.
//

import UIKit

class TVCell: UICollectionViewCell {

    @IBOutlet weak var imgTV: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    
    func setCell(movie: Movie){
        lblName.text = movie.original_title
        lblDescription.text = movie.overview
        lblRate.text = "★\(movie.vote_average ?? 0.0)"
        imgTV.downloadImage(from: URL(string: "\(TargetEnvironment.URL_MEDIA)/\(movie.poster_path!)")!)
        lblDate.text = (movie.release_date ?? "").toDateString()
    }
    
}
