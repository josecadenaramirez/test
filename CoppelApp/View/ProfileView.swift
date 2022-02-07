//
//  ProfileView.swift
//  CoppelApp
//
//  Created by Jose Cadena on 06/02/22.
//

import UIKit

class ProfileView: UIViewController {

    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: ProfileViewModel?{
        didSet{
            viewModel?.getInfo()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "TVCell", bundle: .main), forCellWithReuseIdentifier: "cell")
        viewModel = ProfileViewModel()
        viewModel?.delegate = self
        Loader.hideLoading()
        viewModel?.getInfo()
    }
    

}

extension ProfileView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.favorites.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TVCell
        cell.setCell(movie: viewModel!.favorites[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 20) / 2
        return (CGSize(width: width, height: collectionView.frame.height - 20))
    }
    
    
}

extension ProfileView: ProfileViewModelToView{
    func refreshUI() {
        Loader.hideLoading()
        lblUsername.text = UserInfo.shared.userName
        collectionView.reloadData()
    }
    
    
}
