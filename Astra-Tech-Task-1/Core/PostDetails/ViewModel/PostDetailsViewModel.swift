//
//  PostDetailsViewModel.swift
//  Astra-Tech-Task-1
//
//  Created by Ahmad Ellashy on 16/10/2024.
//

import Foundation


protocol PostDetailsViewModelDelegate{
    func updateUI()
    func errorOccured(err: String)
}

protocol PostDetailsViewModelProtocol{
    func deletePost(id: Int)
}


class PostDetailsViewModel: PostDetailsViewModelProtocol{
    //MARK: - Properties
    var delegate: PostDetailsViewModelDelegate?
    
    //MARK: - Helpers
    func deletePost(id: Int){
        ApiManager.shared.deletePostApi(id: id) { [weak self] result in
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
