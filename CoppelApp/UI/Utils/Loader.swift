//
//  Loader.swift
//  CoppelApp
//
//  Created by Jose Cadena on 06/02/22.
//

import UIKit

var vwBlock:UIView!
var vwLoading:UIActivityIndicatorView!
var flag:Bool = false
public class Loader{
    static let sharedInstance = Loader()
    
    public static func showLoading(_ delegate:UIView){
        DispatchQueue.main.async {
            flag = true
            UIView.animate(withDuration: 0.35, animations: {
                vwBlock = UIView(frame: CGRect(x: 0, y: 0, width: delegate.frame.width, height: delegate.frame.height))
                vwBlock.backgroundColor = UIColor(named: "Background")!.withAlphaComponent(0.3)
                vwLoading = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 110, height: 110))
                delegate.addSubview(vwBlock)
                vwBlock.addSubview(vwLoading)
                vwLoading.center = vwBlock.center
                vwLoading.color = UIColor(named: "Primary")
                vwLoading.startAnimating()
            },completion:nil)
        }
        
    }
    
    public static func hideLoading(){
        DispatchQueue.main.async {
            if flag{
                UIView.animate(withDuration: 0.35, animations: {
                    vwBlock.removeFromSuperview()
                },completion:nil)
            }
        }
        
    }
    
}
