//
//  ApiManager.swift
//  Astra-Tech-Task-1
//
//  Created by Ahmad Ellashy on 15/10/2024.
//

import Foundation
import UIKit

class ApiManager{
    
    static let shared = ApiManager()
    
    func getPostsApi(completion: @escaping (Result<Data,ApiErrors>)-> Void){
        let endPoint = EndPoints.getPosts.rawValue
        guard let url = URL(string: AppConstants.baseUrl + endPoint) else{return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let err = error {
                    print(err)
                    completion(.failure(.somethingWentWrongError))
                }
                guard let data = data,let res = response as? HTTPURLResponse else{return}
                if res.statusCode >= 200 && res.statusCode < 301{
                    completion(.success(data))
                }else{
                    completion(.failure(.somethingWentWrongError))
                }
            }
            task.resume()
            
        
    }
    
    func addPostApi(title: String,message: String,image: UIImage,completion: @escaping (Result<Data,ApiErrors>)-> Void){
        let endPoint = EndPoints.createPost.rawValue
        guard let url = URL(string: AppConstants.baseUrl + endPoint) else{return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let postData = createBody(boundary: boundary, title: title, message: message, image: image)
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let err = error {
                print(err)
                completion(.failure(.somethingWentWrongError))
            }
            guard let data = data,let res = response as? HTTPURLResponse else{return}
            if res.statusCode >= 200 && res.statusCode < 301{
                completion(.success(data))
            }else{
                completion(.failure(.somethingWentWrongError))
            }
        }
        task.resume()
        
        
    }
    
    func updatePostApi(id: Int,title: String,message: String,image: UIImage,completion: @escaping (Result<Data,ApiErrors>)-> Void){
        let endPoint = EndPoints.updatePost.rawValue
        guard let url = URL(string: AppConstants.baseUrl + endPoint) else{return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let postData = createBody(boundary: boundary, id: id ,title: title, message: message, image: image)
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let err = error {
                print(err)
                completion(.failure(.somethingWentWrongError))
            }
            guard let data = data,let res = response as? HTTPURLResponse else{return}
            if res.statusCode >= 200 && res.statusCode < 301{
                completion(.success(data))
            }else{
                completion(.failure(.somethingWentWrongError))
            }
        }
        task.resume()
    }
    
    func deletePostApi(id: Int,completion: @escaping (Result<Data,ApiErrors>)-> Void){
        let endPoint = EndPoints.deletePost.rawValue
        guard let url = URL(string: AppConstants.baseUrl + endPoint) else{return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body = "id=\(id)"
        request.httpBody = body.data(using: .utf8)
        
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let err = error {
                    print(err)
                    completion(.failure(.somethingWentWrongError))
                }
                guard let data = data,let res = response as? HTTPURLResponse else{return}
                if res.statusCode >= 200 && res.statusCode < 301{
                    completion(.success(data))
                }else{
                    completion(.failure(.somethingWentWrongError))
                }
            }
            task.resume()
    }
    
    
    private func createBody(boundary: String, id: Int? = nil, title: String, message: String, image: UIImage?) -> Data {
        var body = Data()
        
        if let id = id {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"id\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(id)\r\n".data(using: .utf8)!)
        }
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"post_title\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(title)\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"post_message\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(message)\r\n".data(using: .utf8)!)
        
        if let image = image, let imageData = image.jpegData(compressionQuality: 1.0) {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"post_image\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n".data(using: .utf8)!)
        }
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        return body
    }
    
    
}
