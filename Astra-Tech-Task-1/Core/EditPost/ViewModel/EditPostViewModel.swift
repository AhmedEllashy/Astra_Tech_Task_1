//
//  EditPostViewModel.swift
//  Astra-Tech-Task-1
//
//  Created by Ahmad Ellashy on 16/10/2024.
//

import Foundation
import UIKit

protocol EditPostViewModelDelegate{
    func updateUI()
    func errorOccured(err: String)
}

protocol EditPostViewModelProtocol{
    func updatePost(id: Int,title: String, message: String, img: UIImage)
}


class EditPostViewModel: EditPostViewModelProtocol{
    //MARK: - Properties
    var delegate: EditPostViewModelDelegate?
    
    //MARK: - Helpers
    func updatePost(id:Int,title: String, message: String, img: UIImage) {
        ApiManager.shared.updatePostApi(
            id:id,title: title, message: message, image: img) { [weak self] result in
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
