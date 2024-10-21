//
//  PostDetailsViewController.swift
//  Astra-Tech-Task-1
//
//  Created by Ahmad Ellashy on 16/10/2024.
//

import UIKit

class PostDetailsViewController: UIViewController {
    //MARK: - Properties
    var coordinator: MainCoordinator?
    var id: Int?
    var image: UIImage?
    var imageUrl:String?
    var postTitle: String?
    var message: String?
    var vm: PostDetailsViewModel = PostDetailsViewModel()
    var refershClosure: (() -> Void)?
    //MARK: - UIViews
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postMessageLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    //MARK: - IBActions
    @IBAction func EditButtonPressed(_ sender: UIButton) {
        guard let id else{return}
        let vc = EditPostViewController()
        vc.id = id
        vc.image = image
        vc.postTitle = postTitle
        vc.messsage = message
        vc.coordinator = coordinator
        vc.closure = { [weak self] image, title, message in
            guard let self else{return}
            
            self.postImageView.image = image
            self.postTitleLabel.text = title
            self.postMessageLabel.text = message
        }
        self.navigationController?.pushViewController(vc, animated: true)    }
    @IBAction func deleteButtonPressed(_ sender: Any) {
        guard let id = id else{return}
        Utlities.loadingAlert(vc: self)
        vm.deletePost(id: id)
    }
    
    //MARK: - Helpers
    private func setup(){
        postImageView.addCornerRadius(radius: 15)
        imageSetup()
        postTitleLabel.text = postTitle
        postMessageLabel.text = message
        vm.delegate = self
    }
    
    private func imageSetup(){
        if let imageUrl{
            let url = URL(string: imageUrl)
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
                if let data {
                    DispatchQueue.main.async {
                        self.image = UIImage(data:data)
                        self.postImageView.image = UIImage(data:data)
                    }
                }else{
                    DispatchQueue.main.async {
                        
                        self.postImageView.image = UIImage(systemName: "photo")
                    }
                    
                }
            }
        }
        if let image{
            self.postImageView.image = image
        }
        
    }
    
}

//MARK: -PostDetailsViewModel Delegate
extension PostDetailsViewController: PostDetailsViewModelDelegate{
    func updateUI() {
        DispatchQueue.main.async {
            self.presentedViewController?.dismiss(animated: true)
        }
        self.coordinator?.customAlertController(state: .success,message: "Post Deleted Successfully!", fromVC: self)
    }
    
    func errorOccured(err: String) {
        DispatchQueue.main.async {
            self.presentedViewController?.dismiss(animated: true)
        }
        DispatchQueue.main.async {
            self.coordinator?.customAlertController(state: .error,message: err, fromVC: self)
        }
        
    }
    
    
}
