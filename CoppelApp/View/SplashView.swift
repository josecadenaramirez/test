//
//  ViewController.swift
//  CoppelApp
//
//  Created by Jose Cadena on 04/02/22.
//

import UIKit

class SplashView: UIViewController {

    @IBOutlet var lblSplash: Array<UILabel>!
    var viewModel = SplashViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    private func animateLetters(){
        UIView.animate(withDuration: 0.15, delay:0.1, animations: {
            self.lblSplash[self.viewModel.index].alpha = 1
            self.lblSplash[self.viewModel.index].transform = CGAffineTransform(translationX: 0, y: 0)
        }, completion: {_ in
            self.viewModel.index += 1
            if self.viewModel.index < self.lblSplash.count{
                self.animateLetters()
            }else{
                self.getToken()
            }
        })
    }
    
    func getToken(){
        ApiManager.shared.getToken { result in
            UserInfo.shared.token = result?.request_token
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginView")
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    private func initViews(){
        lblSplash.forEach{
            $0.alpha = 0
            $0.transform = CGAffineTransform(translationX: -20, y: 0)
        }
        animateLetters()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

