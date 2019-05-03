//
//  FBPostController.swift
//  FBSocial
//
//  Created by Ben Huggins on 5/3/19.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation

import UIKit

class FBPostController {
    
    static let shared = FBPostController()
    private init() {}
    
    var fbPosts: [FBPost] = []
    
    func createPost(caption: String, crPhoto: UIImage) -> [FBPost] {
        let myPost = FBPost(fbCaption: caption, fbPhoto: crPhoto)
        return [myPost]
    }
}//End of Class
