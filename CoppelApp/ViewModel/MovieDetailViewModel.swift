//
//  MovieDetailViewModel.swift
//  CoppelApp
//
//  Created by Jose Cadena on 06/02/22.
//

import Foundation

protocol MovieDetailViewModelProtocol {
    var isFavorite: Bool {get set}
    func saveAsFavorite()
    func removeFromFavorites()
}

protocol MovieDetailViewModelToView {
    func refreshUI()
}

class MovieDetailViewModel: NSObject, MovieDetailViewModelProtocol{
    var isFavorite: Bool = false
    var delegate: MovieDetailViewModelToView?{
        didSet{
            if CoreDataStack.shared.getMovies().contains(where: {$0.id == movie.id ?? 0}){
                isFavorite = true
            }else{
                isFavorite = false
            }
            delegate?.refreshUI()
        }
    }
    var movie: Movie
    
    func saveAsFavorite() {
        CoreDataStack.shared.saveAsFav(movie: movie)
        delegate?.refreshUI()
    }
    
    func removeFromFavorites() {
        CoreDataStack.shared.removeFromFavorites(movie: movie)
        delegate?.refreshUI()
    }
    
    init(movie: Movie){
        self.movie = movie
    }
    
}
