//
//  LoginView.swift
//  CoppelApp
//
//  Created by Jose Cadena on 04/02/22.
//

import UIKit
import Combine
class LoginView: UIViewController, LoginViewModelProtocolToView {
    @IBOutlet weak var edtPass: UITextField!
    @IBOutlet weak var edtUser: UITextField!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    
    var userCredentials: UserCredentials?{
        didSet{
            loadUI()
        }
    }
    var viewModel: LoginViewModel? {
        didSet {
            loadUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userCredentials = UserCredentials(username: "", password: "")
        viewModel = LoginViewModel(delegate: self)
        viewModel?.delegate = self
        navigationController?.setNavigationBarHidden(true, animated: false)
        configTapGesture()
    }
    
    private func configTapGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickHideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func clickHideKeyboard(){
        view.endEditing(true)
    }
    
    func displayError(){
        Loader.hideLoading()
        lblError.isHidden = false
    }
    
    func hideError(){
        lblError.isHidden = true
    }
    
    func continueFromLogin() {
        Loader.hideLoading()
        goToHome()
    }
    
    @IBAction func clickLogin(_ sender: Any) {
        view.endEditing(true)
        Loader.showLoading(view)
        viewModel?.userCredentials = userCredentials
        viewModel?.login()
    }
    
    fileprivate func loadUI() {
        if let areValidFields = viewModel?.validateFields(userCredentials: userCredentials){
            btnLogin.isEnabled = areValidFields
            btnLogin.backgroundColor = areValidFields ? UIColor(named: "Primary") : UIColor.lightGray
        }
    }
    
    private func setUserCredentials(){
        userCredentials?.username = edtUser.text!
        userCredentials?.password = edtPass.text!
        loadUI()
    }
    
    func goToHome(){
        DispatchQueue.main.async {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TVShowsView")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.changeRootViewController(vc: vc!)
        }
    }
}

extension LoginView: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        setUserCredentials()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        setUserCredentials()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        hideError()
    }
}
