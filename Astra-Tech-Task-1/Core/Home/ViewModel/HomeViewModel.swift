//
//  HomeViewModel.swift
//  Astra-Tech-Task-1
//
//  Created by Ahmad Ellashy on 15/10/2024.
//

import UIKit


//MARK: - Protocol
protocol HomeViewModelProtocol: NSObject{
    var posts: [RealPostModel] {get set}
    func getPosts()
}

//MARK: - Delegate
protocol HomeViewModelDelegate{
    func updateUI()
    func errorOccured(err: String)
}

class HomeViewModel: NSObject,HomeViewModelProtocol{
    //MARK: - Properties
    var apiManager: ApiManager = ApiManager()
    var posts: [RealPostModel] = []
    var delegate: HomeViewModelDelegate?
    static let shared = HomeViewModel()
        
    //MARK: - Life Cycle
    init(delegate: HomeViewModelDelegate? = nil) {
        self.delegate = delegate
    }
    //MARK: - Helpers
    func getPosts() {
        apiManager.getPostsApi { [weak self] result in
            guard let self else{return}
            switch result{
            case .success(let data):
                do{
                    let decodedData = try JSONDecoder().decode([PostModel].self, from: data)
                    var tempArr = [RealPostModel]()
                    for item in decodedData{
                        if let img = self.downloadImage(imageUrl: item.postImage){
                            let realPost = RealPostModel(id: item.id, postTitle: item.postTitle, postMessage: item.postMessage,postImage: UIImage(data: img))
                            tempArr.append(realPost)
                        }else{
                            let realPost = RealPostModel(id: item.id, postTitle: item.postTitle, postMessage: item.postMessage)
                            tempArr.append(realPost)
                        }
                        self.posts = tempArr
                    }
                    
                    self.delegate?.updateUI()
                }catch{
                    self.delegate?.errorOccured(err: error.localizedDescription)
                    print(error)
                }
            case .failure(let error):
                self.delegate?.errorOccured(err: error.localizedDescription)
                print(error)
            }
        }
    }
    func downloadImage(imageUrl: String) -> Data?{
        let url = URL(string: imageUrl)
        let data = try? Data(contentsOf: url!)
        return data
    }

    
    
}
