//
//  LoginViewModel.swift
//  CoppelApp
//
//  Created by Jose Cadena on 04/02/22.
//

import Foundation
protocol LoginViewModelProtocol {
    var userCredentials: UserCredentials?{get set}
    func login()
    func validateFields(userCredentials: UserCredentials?)->Bool
}

protocol LoginViewModelProtocolToView{
    func displayError()
    func continueFromLogin()
}

class LoginViewModel: NSObject, LoginViewModelProtocol{

    var delegate: LoginViewModelProtocolToView?
    var userCredentials: UserCredentials?
    
    func login() {
        if let user = userCredentials{
            ApiManager.shared.login(user: user) { result in
                if let result = result, let success = result.success{
                    success ? self.setLoginSuccess(token: result.request_token) : self.delegate?.displayError()
                }else{
                    self.delegate?.displayError()
                }
            }
        }
    }
    
    
    func setLoginSuccess(token:String?){
        UserInfo.shared.token = token
        UserInfo.shared.userName = userCredentials?.username
        delegate?.continueFromLogin()
    }
    
    func validateFields(userCredentials: UserCredentials?) -> Bool {
        if let user = userCredentials{
            return !user.username.isEmpty && !user.password.isEmpty
        }
        return false
    }
    
    init(with userCredentials: UserCredentials? = nil, delegate: LoginViewModelProtocolToView? = nil){
        if let user = userCredentials{
            self.userCredentials = user
        }
    }
}
