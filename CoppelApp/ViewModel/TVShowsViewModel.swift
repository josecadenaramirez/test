//
//  TVShowsViewModel.swift
//  CoppelApp
//
//  Created by Jose Cadena on 06/02/22.
//

import Foundation

protocol TVShowsViewModelProtocol {
    var moviesToShow: [Movie]?{get set}
    var optionSelected: Int { get set }
    var page:Int{get set}
    func getMovies()
    func setNewOption(option: Int)
}

protocol TVShowsViewModelToView {
    func refreshUI()
}

class TVShowsViewModel: NSObject, TVShowsViewModelProtocol{
    var moviesToShow: [Movie]? = []
    var page: Int = 1
    var optionSelected: Int = 0
    var delegate: TVShowsViewModelToView?
    
    func setNewOption(option: Int) {
        moviesToShow?.removeAll()
        optionSelected = option
        page = 1
        getMovies()
    }
    
    func getMovies() {
        ApiManager.shared.getMovies(optionSelected: optionSelected, page: page) { [self] result in
            if let result = result, let movies = result.results{
                self.moviesToShow! += movies
                Loader.hideLoading()
                self.delegate?.refreshUI()
            }
        }
    }
    
    init(with option: Int = 0){
        
    }
    
}
