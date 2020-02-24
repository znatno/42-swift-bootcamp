//
//  APIConnection.swift
//  42Events
//
//  Created by Denis ROMANICHENKO on 2/9/20.
//  Copyright © 2020 Denis ROMANICHENKO. All rights reserved.
//

import Foundation

enum crededntials : String {
    //your application's intra id & secret key
    case client_id = "fc753097ef2f2d4469f4545314aa8e6a20336169457cc1a21ab58e27fd6eb08a"
    case client_secret = "d93cadb00ecd2db57fb9520446ecfa7771de141a9750b36b4097ae1653b9db97"
}

class APIConnection{
    var token:String!=""
    func genTok(completion: @escaping (_ token: String) -> ()){
        //setup URL and headers
        let url = URL(string: "https://api.intra.42.fr/oauth/token?client_id=\(crededntials.client_id.rawValue)&client_secret=\(crededntials.client_secret.rawValue)&grant_type=client_credentials")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        //make request task
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }
                if let data = data, let _ = String(data: data, encoding: .utf8) {
                    //print("data: \(dataString)")
                    let jData = try? JSONSerialization.jsonObject(with: data, options: [])
                    if let jData = jData as? [String: Any] {
                        //print(jData)
                        self.token = jData["access_token"] as? String
                        //                                print("Self: \(self.token)")
                        completion(self.token)
                    }
                }
            }
        }
        task.resume()
        print("Task resumed, getting Token")
        //        return token;
    }
    func getToken()->String{
        return token
    }
}
