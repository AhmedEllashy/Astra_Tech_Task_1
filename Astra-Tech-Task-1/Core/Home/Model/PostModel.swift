//
//  PostModel.swift
//  Astra-Tech-Task-1
//
//  Created by Ahmad Ellashy on 15/10/2024.
//

import UIKit


struct PostModel: Codable{
    let id: Int
    let postTitle: String
    let postMessage: String
    let postImage: String
    enum CodingKeys: String, CodingKey{
        case id
        case postTitle = "post_title"
        case postMessage = "post_message"
        case postImage = "post_image"
    }

}
struct RealPostModel{
    var id: Int
    var postTitle: String
    var postMessage: String
    var postImage: UIImage?
}
