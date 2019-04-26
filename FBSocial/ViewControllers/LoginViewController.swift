//
//  LoginViewController.swift
//  FBSocial
//
//  Created by Ben Huggins on 4/20/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FacebookShare
import FBSDKCoreKit



class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginWithFaceBook(_ sender: Any) {
      let manager = LoginManager()
      
     // manager.logIn(readPermissions: [.publicProfile, .email], viewController: self) { (result) in
      manager.logIn(publishPermissions: [.managePages, .publishPages], viewController: self) { (result) in
        
            switch result {
            case .cancelled:
                print("User cancelled Login")
                break
            case .failed(let error):
                print("Login failed with error = \(error.localizedDescription)")
                break
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("access token: \(accessToken)")
                self.getUserProfile()
            }
        }
    }
    
    func getUserProfile() {
        let connection = GraphRequestConnection()
        connection.add(GraphRequest(graphPath: "/me", parameters:["fields":"id,name,about,birthday"], accessToken: AccessToken.current, httpMethod: .GET, apiVersion: GraphAPIVersion.defaultVersion)) {
            response, result in
            switch result {
            case .success(let response):
                print("😅Logged in user facebook id: \(String(describing: response.dictionaryValue?["id"]))")
                print("😅Logged in user facebook Name: \(String(describing: response.dictionaryValue?["name"]))")
                print("😅Logged in user facebook About: \(String(describing: response.dictionaryValue?["about"]))")
                print("😅Logged in user facebook Birthday: \(String(describing: response.dictionaryValue?["birthday"]))")
                break
            case .failed(let error):
                print("We have an error fetching logged in user profile: \(error.localizedDescription)")
            }
        }
        connection.start()
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        //faceBookShare()
        //facebookShare2()
        facebookShare3()
    }
    func faceBookShare()
    {
        
        let content:LinkShareContent = LinkShareContent.init(url: URL.init(string: "https://www.facebook.com/holmes.huggins/timeline?lst=1075524270%3A1075524270%3A1555805724") ?? URL.init(fileURLWithPath: "https://developers.facebook.com"), quote: "Share This Content")
        
        let shareDialog = ShareDialog(content: content)
        shareDialog.mode = .native
        shareDialog.failsOnInvalidData = true
        shareDialog.completion = { result in
            print("shared successfully")
        }
        do
        {
            try shareDialog.show()
        }
        catch
        {
            print("Exception")
            
        }
    }
    
    
    func facebookShare2() {
        
        
       // let manager = LoginManager()
        print("share button tapped")
        
        let urlString = "123123"
 
        let content = LinkShareContent(url: URL(string: urlString)!)
        
        let sharer = GraphSharer(content: content)
        //sharer.graphNode = "/\(pageId)"
       
        sharer.failsOnInvalidData = true
        sharer.completion = {
            (result) in
            
            print(result)
        }
        
        do {
            try sharer.share()
        }
        catch (let error) {
            print(error.localizedDescription)
        }

}
    // message = "(#100) Graph API for app id 447734622637775 called, but token has app id 1532460837044551";
    
    //447734622637775      app id
    //10216250109900168    user
    //1285691484917122     page
    //EAAGXNlcizs8BAOmBUit9K191z3ActV7dsVqZAjVtZARSc9jo4v9hMhUoKpyasYFnuqmsRtlLhlSnpis9EahEkZAQZCjSYxhkfAu5ZB7YpOFOKDZBB4tZAXm2F5OTSOm3UIMnYZCp5V3QnZBV6FbFORUgTJoN4udxYOC5Dfh7fZBmkvfAZDZD
    
//    EAAGXNlcizs8BAOA2zByAbcVER0GOO9cKz1a9CRDYEzOZCCnHxScbCU7H5OmaHJW9Os3faxRtKN06fL0Nmx8soEeUFVTJhnJoMCriG72dAqAv9zZCNcdTq0oRDZCotg6nVCp0WkU8hHRLPz98ZAJfxwYZB4dp3kxy8gjNO24k5KwZDZD
    
    
//    https://graph.facebook.com/1285691484917122/feed?message=Hello!&access_token=EAAGXNlcizs8BAA7xBmILhBCzytk0BSHoVXOTCUz1HxMbQLt4vCFB8LYZCrtfaXbybuudx6MeQQNr9HiTdTZAN93zfTXpdfNBiF54B59k2SFUjeZCBv9YApY01uWgfWwlZClpKVyKbXZCxNKzgbJho73988IT4yGKEsuZBDnJONrOJKvBdOJSXgkY9G6QJ3Wnxs4o2ohTEwOAZDZD
    
    func facebookShare3(){
        
     
        let request = FBSDKGraphRequest(graphPath: "/1285691484917122/feed", parameters: [
            "message": "4567889"
            ], httpMethod: "POST")
        request!.start(completionHandler: { connection, result, error in
//            dump(connection)
//            dump(result)
            dump(error)
            print(error?.localizedDescription)
            
        })
        
    }
    
    
    
}
