//
//  ApiConfigs.swift
//  Astra-Tech-Task-1
//
//  Created by Ahmad Ellashy on 15/10/2024.
//

import Foundation

enum HttpMethods: String{
    case POST
    case GET
    case DELETE

}

enum EndPoints: String{
    case createPost = "create"
    case getPosts = "getposts"
    case updatePost = "updatepost"
    case deletePost = "deletepost"
}
