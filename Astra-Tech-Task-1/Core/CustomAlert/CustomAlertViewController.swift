//
//  CustomAlertViewController.swift
//  Astra-Tech-Task-1
//
//  Created by Ahmad Ellashy on 15/10/2024.
//

import UIKit

enum AlertState{
    case success
    case error
}
//
class CustomAlertViewController: UIViewController {
    //MARK: - Properties
    var coordinator: MainCoordinator?
    var imageName: String?
    var alertTitle: String?
    var message: String?
    var state: AlertState = .success
    //MARK: - UIViews
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dataView: UIView!
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dataView.addCornerRadius(radius: 15)
        setup()
    }
    @IBAction func dismissButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    //MARK: - Helpers
    private func setup(){
    
        if state == .success{
            imageView.image = UIImage(systemName: "checkmark.message.fill")
            titleLabel.text = "Success"

        }else{
            imageView.image = UIImage(systemName: "xmark.seal.fill")
            imageView.tintColor = UIColor.red
            titleLabel.text = "error"

        }
        messageLabel.text = message
    }
    
}
