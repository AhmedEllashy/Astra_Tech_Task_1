//
//  EditPostViewController.swift
//  Astra-Tech-Task-1
//
//  Created by Ahmad Ellashy on 16/10/2024.
//

import UIKit

class EditPostViewController: UIViewController,UINavigationControllerDelegate {
    //MARK: - Properties
    var coordinator: MainCoordinator?
    var id: Int = 0
    var image: UIImage?
    var postTitle: String?
    var messsage: String?
    var editViewModel = EditPostViewModel()
    var closure: ((_ image: UIImage, _ title:String, _ message:String) -> Void)?
    var picker: UIImagePickerController = UIImagePickerController()

    //MARK: - UIViews
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var MessageTextField: UITextField!

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    //MARK: - IBActions
    @IBAction func UpdateButtonPressed(_ sender: UIButton) {
        if  let postTitle = titleTextField.text, let messsage = MessageTextField.text, let image = image {
            Utlities.loadingAlert(vc: self)
            editViewModel.updatePost(id: id, title: postTitle, message: messsage, img: image)
        }else{
            coordinator?.customAlertController(state: .error, message: "All Fields are required", fromVC: self)
        }
    }
    //MARK: - Helpers
    private func setup(){
        titleView.addCornerRadius(radius:15)
        messageView.addCornerRadius(radius:15)
        postImageView.addCornerRadius(radius: 15)
        postImageView.image = image ?? UIImage(systemName: "photo")
        titleTextField.text = postTitle
        MessageTextField.text = messsage
        editViewModel.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapPostImage(_:)))
        postImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func didTapPostImage(_ sender: UITapGestureRecognizer){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            picker.delegate = self
            picker.sourceType = .savedPhotosAlbum
            picker.allowsEditing = false
            self.present(picker,animated: true)
        }
    
    }
    
}

//MARK: - EditPostViewModelDelegate Methods
extension EditPostViewController: EditPostViewModelDelegate{
    func updateUI() {
        DispatchQueue.main.async {
            self.presentedViewController?.dismiss(animated: true)
            
            self.coordinator?.customAlertController(state:.success , message: "Post Updated Successfully", fromVC: self)
            guard let image = self.postImageView.image, let postTitle = self.titleTextField.text, let messsage = self.MessageTextField.text else{return}
            self.closure?(image, postTitle, messsage)

        }

        
        
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

//MARK: - EditPostViewModelDelegate Methods
extension EditPostViewController: UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true)
        guard let img = info[.originalImage] as? UIImage else {return}
        postImageView.image = img
        self.image = img
    }
}
