//
//  MainCoordinator.swift
//  Astra-Tech-Task-1
//
//  Created by Ahmad Ellashy on 16/10/2024.
//

import UIKit

protocol Coordinator{
    var childCoordinators: [Coordinator]? {get set}
    var navController: UINavigationController {get set}
    
    func start()

}
class MainCoordinator: Coordinator{
    var childCoordinators: [Coordinator]?
    
    var navController: UINavigationController
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    func start() {
        print("start")
        let vc = HomeViewController()
        vc.coordinator = self
        navController.pushViewController(vc, animated: false)
    }
    
    func postDetailsViewController(id:Int,image: UIImage?,title: String,message: String){
        let vc = PostDetailsViewController()
        vc.coordinator = self
        vc.id = id
        vc.image = image
        vc.postTitle = title
        vc.message = message
        navController.pushViewController(vc, animated: true)
    }
    func addPostViewController(){
        let vc = AddPostViewController()
        vc.coordinator = self
        navController.pushViewController(vc, animated: true)
    }
    func editPostViewController(id: Int,title: String?,message: String?,image: UIImage?){
        let vc = EditPostViewController()
        vc.coordinator = self
        vc.id = id
        vc.image = image
        vc.postTitle = title
        vc.messsage = message
        navController.pushViewController(vc, animated: true)
    }
    func customAlertController(image: String,title: String,message: String,fromVC:UIViewController){
        let vc = CustomAlertViewController()
        vc.imageName = image
        vc.alertTitle = title
        vc.message = message
        vc.modalPresentationStyle = .overCurrentContext
        vc.coordinator = self
        fromVC.present(vc, animated: true)
        
    }
    func popUp(vc: UIViewController){
        vc.navigationController?.popViewController(animated: true)
    }
}
