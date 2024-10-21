//
//  AddPostViewController.swift
//  Astra-Tech-Task-1
//
//  Created by Ahmad Ellashy on 16/10/2024.
//

import UIKit

class AddPostViewController: UIViewController, UINavigationControllerDelegate {
    //MARK: - Properties
    var coordinator: MainCoordinator?
    var picker = UIImagePickerController()
    var image: UIImage?
    var addPostViewModel = AddPostViewModel()
    //MARK: - UIViews
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var messageTextField: UITextField!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - IBActions
    @IBAction func createButtonPressed(_ sender: UIButton) {
        if let postTitle = titleTextField.text , let message = messageTextField.text , let image = image{
            Utlities.loadingAlert(vc: self)
            addPostViewModel.createPost(title: postTitle, message: message, img: image)
        }else{
            self.presentedViewController?.dismiss(animated: true)
            coordinator?.customAlertController(state:.error, message: "All Fields are required", fromVC: self)
        }
        
    }
    //MARK: - Helpers
    private func setup(){
        postImageView.addCornerRadius(radius: 15)
        titleView.addCornerRadius(radius: 15)
        messageView.addCornerRadius(radius: 15)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapPostImageView(_:)))
        titleTextField.delegate = self
        messageTextField.delegate = self
        addPostViewModel.delegate = self
        postImageView.isUserInteractionEnabled = true
        postImageView.addGestureRecognizer(tapGestureRecognizer)
        
        

    }

    @objc private func didTapPostImageView(_ gesture: UIGestureRecognizer){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            picker.delegate = self
            picker.sourceType = .savedPhotosAlbum
            picker.allowsEditing = false
            self.present(picker,animated: true)
        }   
    }
    
}

//MARK: - UIImagePickerControllerDelegate Methods
extension AddPostViewController: UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true)
        guard let img = info[.originalImage] as? UIImage else {return}
        postImageView.image = img
        self.image = img
    }
}


//MARK: - AddPostViewModelDelegate Methods
extension AddPostViewController: AddPostViewModelDelegate{
    func updateUI() {
        DispatchQueue.main.async {
            self.presentedViewController?.dismiss(animated: true)
            
            self.coordinator?.customAlertController(state:.success, message: "Post Created Succesfully", fromVC: self)
            
            self.titleTextField.text = ""
            self.messageTextField.text = ""
            self.postImageView.image = UIImage(systemName: "photo")
        }
            
    }
    
    func errorOccured(err: String) {
        DispatchQueue.main.async {
            self.coordinator?.customAlertController(state: .error,message: err, fromVC: self)
        }
    }
    
    
}

extension AddPostViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
