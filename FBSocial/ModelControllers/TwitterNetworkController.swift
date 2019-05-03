//
//  TwitterNetworkController.swift
//  FBSocial
//
//  Created by Ben Huggins on 4/30/19.
//  Copyright © 2019 User. All rights reserved.
//



import Foundation

class TwitterNetworkController {

    let baseUrl = URL(string: "https://api.twitter.com/oath/request_token")

    let consumerApiKey = "SKuXmSPU5hKnK7riEGKuvO6RV"

    let consumerApiKeySecret = "3zbun7JwDtZU4DRVpW46kYfKgDFFRY8qTIEKTB6ENUKj1FlNLP"

    let nonce = "ABCDEFGHIJKLMoOPQRSTyVWXYZ123abc"

    let version = "1.0"

    let timeStamp = "1556664814"

    let signatureMethod = "HMAC-SHA1"

   // let Authorization = "OAuth oauth_consumer_key="SKuXmSPU5hKnK7riEGKuvO6RV",oauth_signature_method="HMAC-SHA1",oauth_timestamp="1556664814",oauth_nonce="ABCDEFGHIJKLMoOPQRSTyVWXYZ123abc",oauth_version="1.0",oauth_signature="3V5j%2BvrVhOFdd7YjsDa2aGObncc%3D"

    let oauth_consumer_key =  "SKuXmSPU5hKnK7riEGKuvO6RV",oauth_signature_method="HMAC-SHA1",oauth_timestamp="1556664814",oauth_nonce="ABCDEFGHIJKLMoOPQRSTyVWXYZ123abc",oauth_version="1.0",oauth_signature="3V5j%2BvrVhOFdd7YjsDa2aGObncc%3D"

    static let sharedTwitterInstance = FBNetworkController()


    func postToTwitterWith(value: String, pageAcessToken: String, idSame: String, completion: @escaping ((Bool) -> Void)) {


        let Url = String(format: "https://api.twitter.com/oath/request_token")
        guard let serviceUrl = URL(string: Url) else { return }
       // let parameterDictionary = [ : ]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Authorization", forHTTPHeaderField: "Content-Type")
      //  guard let httpBody = try? JSONSerialization.data( withJSONObject: Any, options: []) else {
      //      return
     //   }
      //  request.httpBody = httpBody
        print("🤝🤝🤝🤝🤝🤝🤝🤝🤝🤝🤝🤝🤝🤝")
        print(request)
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
                print("👿👿👿👿👿👿👿👿👿👿")
                dump(data)
            }
            }.resume()
    }
}










