//
//  UIViewExten.swift
//  Astra-Tech-Task-1
//
//  Created by Ahmad Ellashy on 15/10/2024.
//

import UIKit


extension UIView{
    var width : CGFloat {
       return frame.size.width
   }
    var height : CGFloat {
       return frame.size.height
   }
    var left : CGFloat {
       return frame.origin.x
   }
    var right : CGFloat {
       return left + width
   }
    var top : CGFloat {
       return frame.origin.y
   }
    var bottom : CGFloat {
       return top + height
   }
    func addCornerRadius(radius:CGFloat){
        clipsToBounds = true
        layer.masksToBounds = true
        layer.cornerRadius = radius
    }
}
