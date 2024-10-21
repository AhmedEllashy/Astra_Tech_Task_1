//
//  HomeViewController.swift
//  Astra-Tech-Task-1
//
//  Created by Ahmad Ellashy on 15/10/2024.
//

import UIKit

class HomeViewController: UIViewController {
    //MARK: - Properties
    private let homeViewModel: HomeViewModel = HomeViewModel()
    var coordinator: MainCoordinator?

    
    //MARK: - UIViews
   private let postsTableView: UITableView = {
       let tableView = UITableView(frame: .zero)
       tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        return tableView
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        homeViewModel.getPosts()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        postsTableView.frame = view.bounds
    }
    
    //MARK: - Helpers
    fileprivate func setup(){
        view.addSubview(postsTableView)
        postsTableView.delegate = self
        postsTableView.dataSource = self
        homeViewModel.delegate = self
        addplusNavBarButton()
        title = "Home"
        Utlities.loadingAlert(vc: self)

//        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    private func addplusNavBarButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(addPostButtonPressed))
    }
    @objc private func addPostButtonPressed(){
        coordinator?.addPostViewController()
    }
    
}

//MARK: - TableViewDataSource Methods
extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell
        else{
            return UITableViewCell()
        }
        let post = homeViewModel.posts[indexPath.row]
        
        cell.config(post: post)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

//MARK: - TableViewDelegate Methods
extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = homeViewModel.posts[indexPath.row]
        guard let cell = tableView.cellForRow(at: indexPath) as? PostTableViewCell else {return}
        let img: UIImage? = cell.image
        if let img{
            self.coordinator?.postDetailsViewController(realPost: RealPostModel(id: post.id, postTitle: post.postTitle, postMessage: post.postMessage, postImage: img))
        }else{
            self.coordinator?.postDetailsViewController(post: PostModel(id: post.id, postTitle: post.postTitle, postMessage: post.postMessage, postImage: post.postImage))

        }

        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

extension HomeViewController: HomeViewModelDelegate{
    func updateUI() {
        DispatchQueue.main.async {
            self.presentedViewController?.dismiss(animated: true)
            self.postsTableView.reloadData()
        }
    }
    
    func errorOccured(err: String) {
        DispatchQueue.main.async {
            self.coordinator?.customAlertController(state:.error, message: err,fromVC: self)
        }
    }
    
    
}
