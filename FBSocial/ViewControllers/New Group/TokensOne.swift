//
//  TokensOne.swift
//  FBSocial
//
//  Created by Ben Huggins on 4/29/19.
//  Copyright © 2019 User. All rights reserved.
//
// The user has multiple pages each with a pageId, pageToken and name 


import Foundation

class TokensOne {
    
    var accessTokensOne: [String]
    var namesOfPages: [String]
    var pageIds: [String]
    
    init(accessTokensOne: [String], namesOfPages: [String], pageIds: [String]) {
        self.accessTokensOne = accessTokensOne
        self.namesOfPages = namesOfPages
        self.pageIds = pageIds
        
    }
    
    
    
    
}
