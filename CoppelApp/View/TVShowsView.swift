//
//  TVShowsView.swift
//  CoppelApp
//
//  Created by Jose Cadena on 05/02/22.
//

import UIKit

class TVShowsView: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedButtons: UISegmentedControl!
    
    var viewModel: TVShowsViewModel?{
        didSet{
            setUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = TVShowsViewModel()
        viewModel?.delegate = self
        collectionView.register(UINib(nibName: "TVCell", bundle: .main), forCellWithReuseIdentifier: "cell")
    }
    
    private func setUI(){
        setSegmentedUI()
        navigationController?.setNavigationBarHidden(false, animated: true)
        getMovies()
        let addFav = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(clickMenu))
        navigationItem.rightBarButtonItems = [addFav]
        navigationController?.navigationBar.barTintColor = UIColor(named: "Background")
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    private func getMovies(){
        viewModel?.getMovies()
    }
    
    @objc func clickMenu(){
        let buttons = [
            AlertAction(title: "Perfil", action: {self.goToProfile()},style: .default),
            AlertAction(title: "Logout", action: {self.goToLogin()},style: .destructive),
            AlertAction(title: "Cancelar",style: .cancel)
            
        ]
        self.present(buildAlert(title: "Qué quieres hacer?", buttonsTitle: buttons), animated: true)
    }
    
    private func goToProfile(){
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileView"){
            self.present(vc, animated: true)
        }
    }
    
    private func goToLogin(){
        UserInfo.shared.token = nil
        UserInfo.shared.userName = nil
        CoreDataStack.shared.removeAll()
        if let vc = storyboard?.instantiateViewController(withIdentifier: "LoginView"){
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.changeRootViewController(vc: vc)
        }
    }
    
    private func setSegmentedUI(){
        segmentedButtons.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentedButtons.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
    }

    @IBAction func clickOptions(_ sender: Any) {
        viewModel?.setNewOption(option: segmentedButtons.selectedSegmentIndex)
    }
}

extension TVShowsView: TVShowsViewModelToView{
    func refreshUI() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            if self.viewModel?.page == 1{
                self.collectionView.setContentOffset(CGPoint(x:0,y:0), animated: false)
            }
        }
    }
    
    
}

extension TVShowsView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TVCell
        if let moviesArray = viewModel?.moviesToShow{
            cell.setCell(movie: moviesArray[indexPath.item])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.moviesToShow?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 20) / 2
        return (CGSize(width: width, height: 400))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let moviesArray = viewModel?.moviesToShow{
            let vc = storyboard?.instantiateViewController(withIdentifier: "MovieDetailsView") as! MovieDetailsView
            vc.movie = moviesArray[indexPath.item]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastIndex = (self.viewModel?.moviesToShow?.count ?? 0 ) - 1
        if indexPath.row == lastIndex {
            viewModel!.page += 1
            getMovies()
        }
    }
    
}
