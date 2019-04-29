//
//  FBNetworkController.swift
//  FBSocial
//
//  Created by Ben Huggins on 4/26/19.
//  Copyright © 2019 User. All rights reserved.
//


//1//https://graph.facebook.com/me/accounts?fields=about,access_token,name&access_token=EAAGXNlcizs8BANg3uDlconvdt2hEd3mpo5WOtbZCwUZCBD3Wz9TdYBmalKgkl7Y9kAkqOJrJa8PzZCvRydaYrgqZAS0fR1SrdMqi4t5HCuPWwvA7ZBwcK0w0AARnVKuv8sTIGxBcSZAvvrZByRb27BzwXognIVabzfN0XRbDrCOWwZDZD

import Foundation
import UIKit

class FBNetworkController {
    
    var accessToken1 = ""
    
    var accessTokens: [String] = []
    var namesOfPages: [String] = []
    var pageIds: [String] = []        //<== remember this gets called more than once
    
    static let sharedInstance = FBNetworkController()
    
    let baseUrl = URL(string: "https://graph.facebook.com")
    
    // should I pass the user Token 
    func getPageIDWithUserAccessToken(completion: @escaping (([String],[String],[String]) -> Void)) {
        
        guard var url = baseUrl else {return}
        
        url.appendPathComponent("me")
        url.appendPathComponent("accounts")
        
        let fields = URLQueryItem(name: "fields", value: "about,access_token,name")
        let fields2 = URLQueryItem(name: "access_token", value: self.accessToken1)
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = [fields, fields2]
        
        guard let requestURL = components?.url else {completion([],[],[]); return}
        
        print("😔😔😔😔😔😔😔😔😔😔😔😔😔")
        print(requestURL)
        
        var urlRequest = URLRequest(url: requestURL)
        
        urlRequest.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                print("error getting data items from the web: \(error.localizedDescription)")
                completion([],[],[])
                return
            }
            guard let data = data else {
                print(" there wasn no data")
                completion([],[],[])
                return
            }
            guard let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                print("json data was not converted into correct format")
                completion([],[],[])
                return
            }
            //        print("🤩🤩🤩🤩🤩🤩🤩")
            //        dump(jsonDictionary)
            
            guard let jsonList :[[String : Any]] = jsonDictionary?["data"] as? [[String : Any]] else
            { print("jsonItems");  return }
            
            print("😏😏😏😏😏😏😏😏")
            dump(jsonList)
            
            for tokenList in jsonList {
                if let access_token = tokenList["access_token"] as? String,
                    let name = tokenList["name"] as? String,
                    let id = tokenList["id"] as? String {
                    self.accessTokens.append(access_token)
                    self.namesOfPages.append(name)
                    self.pageIds.append(id)
                    
                    //                    print("🥶🥶🥶🥶🥶🥶🥶🥶")
                    //                    print(self.accessTokens)
                    //                    print(self.names)
                    //                    print(self.ids)
                }
            }
            completion(self.accessTokens, self.namesOfPages, self.pageIds)
            
            return
        }
        dataTask.resume()
    }
    
    //    //2//https://graph.facebook.com/1285691484917122?fields=access_token&access_token=EAAGXNlcizs8BANChpgX5HikII1EyeEh6ZA6gM34CHlTqnLvExBVOi2dPbxmX5BT1A1mA1WkvpPVHIn3cYnVfADmJXnVneMlPDTCkDAtRMRWIyrm66MnMta1i4p4IaJctOR5YgVoWCZBnu3BHGljpqSLkBEIqMYreaMscNT4QZDZD
    //
    //    // This will fetch the page Token
    func getPageTokenWithPageID(accessTokens2: String, pageIds: String, completion: @escaping ((String,String) -> Void)) {
        
        print(pageIds)
        
        guard var url = baseUrl else {return}
        
        url.appendPathComponent(pageIds)  //<- need to fix this
        
        let fields = URLQueryItem(name: "fields", value: "access_token")
        let fields2 = URLQueryItem(name: "access_token", value: accessTokens2)
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = [fields, fields2]
        
        guard let requestURL = components?.url else {completion("",""); return}
        
        print("😔😔😔😔😔😔😔😔😔😔😔😔😔")
        print(requestURL)
        
        var urlRequest = URLRequest(url: requestURL)
        
        urlRequest.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                print("error getting data items from the web: \(error.localizedDescription)")
                completion("","")
                return
            }
            guard let data = data else {
                print(" there wasn no data")
                completion("","")
                return
            }
            guard let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                print("json data was not converted into correct format")
                completion("","")
                return
            }
            //             print("🤮🤮🤮🤮🤮🤮🤮🤮🤮🤮")
            //             dump(jsonDictionary)
            
            //extract the data
            guard let pageAccessToken :String = jsonDictionary?["access_token"] as? String,
                let idSame : String = jsonDictionary?["id"] as? String
                else {return}
            
            //             print("🤮🤮🤮🤮🤮🤮🤮🤮🤮🤮")
            //             print(pageAccessToken)
            
            completion(pageAccessToken, idSame)
        }
        
        dataTask.resume()
    }
    
    //https://graph.facebook.com/1285691484917122/feed?message=hey&access_token=EAAGXNlcizs8BAMTGmgY5tPw9AEgDWsj61dfyZC7RQ5qmtDmFhxOAyEYlzNZCh6MuAZAvIX0Y0y4LJbwcfkoRUuOKaijox15MNPvglMMFkVhDiWI0dlvbVxw787xn6NinKLVcLHmptH10g9a0iESifxUC5kTxvcegb07ZAbZBMRwZDZD
    
    
    func postToFaceBookWithPageToken(value: String, pageAcessToken: String, idSame: String, completion: @escaping ((Bool) -> Void)) {
        
        guard var url = baseUrl else {return}
        
        url.appendPathComponent(idSame)  //<- need to fix this
        url.appendPathComponent("feed")
        
        let fields = URLQueryItem(name: "message", value: value)
        let fields2 = URLQueryItem(name: "access_token", value: pageAcessToken)
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = [fields, fields2]
        
        guard let requestURL = components?.url else {completion(false); return}
        
        print("😔😔😔😔😔😔😔😔😔😔😔😔😔")
        print(requestURL)
        
        var message = Message(message: value)
        
        var postData: Data
        
        //post this url
        
        
        do {
            let jsonEncoder = JSONEncoder()
            postData = try jsonEncoder.encode(message)
            completion(true)
        } catch {
            print("\(error.localizedDescription)")
            completion(false)
            return
        }
        
        var urlRequest = URLRequest(url: requestURL)
        
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = postData
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                print("error getting data items from the web: \(error.localizedDescription)")
                completion(false)
                return
            }
            guard let data = data else {
                print(" there wasn no data")
                completion(false)
                return
            }
            
        }
        
        dataTask.resume()
        
    }
}
