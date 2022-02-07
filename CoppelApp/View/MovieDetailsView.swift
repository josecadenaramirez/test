//
//  MovieDetailsView.swift
//  CoppelApp
//
//  Created by Jose Cadena on 06/02/22.
//

import UIKit

class MovieDetailsView: UIViewController {
    
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAdult: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    
    var movie: Movie?
    var viewModel: MovieDetailViewModel?{
        didSet{
            setUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = movie{
            viewModel = MovieDetailViewModel(movie: movie)
            viewModel?.delegate = self
        }
    }
    
    
    private func setUI(){
        lblTitle.text = movie?.title
        lblDate.text = (movie?.release_date ?? "").toDateString()
        lblRate.text = "★\(movie?.vote_average ?? 0.0)"
        lblAdult.text = "+18"
        if let isForAdults = movie?.adult, isForAdults{
            lblAdult.isHidden = !isForAdults
        }else{
            lblAdult.isHidden = true
        }
        lblDescription.text = movie?.overview
        if let url = URL(string: "\(TargetEnvironment.URL_MEDIA)/\(movie?.poster_path ?? "")"){
            imgMovie.downloadImage(from: url)
        }
    }
    
    @IBAction func clickAddFav(_ sender: Any) {
        viewModel?.isFavorite.toggle()
        viewModel?.isFavorite ?? false ? viewModel?.saveAsFavorite() : viewModel?.removeFromFavorites()
    }
}

extension MovieDetailsView: MovieDetailViewModelToView{
    func refreshUI() {
        btnFavorite.setImage(UIImage(systemName: viewModel?.isFavorite ?? false ? "star.fill" : "star"), for: [])
    }
}
