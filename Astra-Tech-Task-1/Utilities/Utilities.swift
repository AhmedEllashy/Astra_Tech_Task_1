//
//  ALert.swift
//  Astra-Tech-Task-1
//
//  Created by Ahmad Ellashy on 16/10/2024.
//

import UIKit

struct Utlities {
    static func loadingAlert(vc: UIViewController){
        let alert = UIAlertController(title: "Updating data", message: "Please wait...", preferredStyle: .alert)
        alert.view.tintColor = UIColor.black
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10,y: 5,width: 50, height: 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        vc.present(alert, animated: true)
    }
}
