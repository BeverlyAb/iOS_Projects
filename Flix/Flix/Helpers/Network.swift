//
//  Network.swift
//  Flix
//
//  Created by Beverly Abadines on 1/29/19.
//  Copyright © 2019 BeverlyAb. All rights reserved.
//

import Foundation

struct Network{
    var urlName : String
    
    //return arrays of dict regardless of the url name
    func getNowPlaying(completion: @escaping ([[String:Any]]?) -> Void){
        let url = URL(string:urlName)
        let request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
              
                var myMovies : [[String:Any]]
                myMovies = dataDictionary["results"] as! [[String:Any]]
                
                return completion(myMovies)
            }
        }
        task.resume()
    }
}
