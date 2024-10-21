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
    func addPostViewController()
    func postDetailsViewController(realPost: RealPostModel?,post: PostModel?)
    func editPostViewController(post:RealPostModel)
    func customAlertController(state: AlertState , message: String,fromVC:UIViewController)
    func popUp(vc: UIViewController)
    

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
    
    func postDetailsViewController(realPost: RealPostModel? = nil,post: PostModel? = nil){
        if let realPost{
            let vc = PostDetailsViewController()
            vc.coordinator = self
            vc.id = realPost.id
            vc.image = realPost.postImage
            vc.postTitle = realPost.postTitle
            vc.message = realPost.postMessage
            navController.pushViewController(vc, animated: true)
        }
        if let post{
            let vc = PostDetailsViewController()
            vc.coordinator = self
            vc.id = post.id
            vc.imageUrl = post.postImage
            vc.postTitle = post.postTitle
            vc.message = post.postMessage
            navController.pushViewController(vc, animated: true)
        }
    }
    
    func addPostViewController(){
        let vc = AddPostViewController()
        vc.coordinator = self
        navController.pushViewController(vc, animated: true)
    }
    
    func editPostViewController(post:RealPostModel){
        let vc = EditPostViewController()
        vc.coordinator = self
        vc.id = post.id
        vc.image = post.postImage
        vc.postTitle = post.postTitle
        vc.messsage = post.postMessage
        navController.pushViewController(vc, animated: true)
    }
    func customAlertController(state: AlertState , message: String,fromVC:UIViewController){
        let vc = CustomAlertViewController()
        vc.message = message
        vc.modalPresentationStyle = .overCurrentContext
        vc.coordinator = self
        vc.state = state
        fromVC.present(vc, animated: true)
    }
    func popUp(vc: UIViewController){
        vc.navigationController?.popViewController(animated: true)
    }
}
