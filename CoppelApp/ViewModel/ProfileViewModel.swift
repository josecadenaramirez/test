//
//  ProfileViewModel.swift
//  CoppelApp
//
//  Created by Jose Cadena on 06/02/22.
//

import Foundation

protocol  ProfileViewModelProtocol{
    func getInfo()
    var favorites: [Movie]{get set}
}

protocol ProfileViewModelToView {
    func refreshUI()
}

class ProfileViewModel: NSObject, ProfileViewModelProtocol{
    var favorites: [Movie] = []
    var delegate: ProfileViewModelToView?
    
    func getInfo() {
        favorites = CoreDataStack.shared.getMovies()
        delegate?.refreshUI()
    }
    
    
    
    override init(){
        
    }
    
}
