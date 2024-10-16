//
//  AddPostViewModel.swift
//  Astra-Tech-Task-1
//
//  Created by Ahmad Ellashy on 16/10/2024.
//

import Foundation
import UIKit

protocol AddPostViewModelDelegate{
    func updateUI()
    func errorOccured(err: String)
}

protocol AddPostViewModelProtocol{
    func createPost(title: String, message: String, img: UIImage)
}


class AddPostViewModel: AddPostViewModelProtocol{
    //MARK: - Properties
    var delegate: AddPostViewModelDelegate?
    
    //MARK: - Helpers
    func createPost(title: String, message: String, img: UIImage) {
        ApiManager.shared.addPostApi(title: title, message: message, image: img) { [weak self]
            result in
            guard let self else{return}
            switch result{
            case .success(_):
                self.delegate?.updateUI()
            case .failure(let err):
                self.delegate?.errorOccured(err: err.rawValue)
                
            }
        }
    }
    
    
}
