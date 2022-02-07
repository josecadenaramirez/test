//
//  Alert.swift
//  CoppelApp
//
//  Created by Jose Cadena on 06/02/22.
//

import UIKit
typealias ActionClosure = () -> Void
struct AlertAction {
    var title:String
    var action: ActionClosure = {}
    var style: UIAlertAction.Style
}
extension UIViewController{
    func buildAlert(title:String? = nil, message:String? = nil, buttonsTitle:[AlertAction]? = nil)->UIAlertController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        if let buttons = buttonsTitle{
            buttons.forEach{
                let action = $0.action
                let btn = UIAlertAction(title: $0.title, style: $0.style){_ in
                    action()
                }
                alert.addAction(btn)
            }
        }
        return alert
    }
}
