//
//  ApiClient.swift
//  DummyMap
//
//  Created by TaMinhQuan on 06/12/2017.
//  Copyright © 2017 Ta Minh Quan. All rights reserved.
//

import UIKit
import Alamofire

let mainURL = "https://my-json-server.typicode.com/quanrong88/Demo-repo/shops"

class ApiClient: NSObject {
    static let sharedInstance = ApiClient()
    func getRestaurantList(completion: @escaping ([RestaurantViewModel]) -> Void) {
        Alamofire.request(mainURL).responseJSON { response in
            switch response.result {
            case .success:
                print("Validation Successful")
                if let json = response.result.value as? [[String:Any]] {
                    var result: [RestaurantViewModel] = []
                    for item in json {
                        let model = RestaurantViewModel(dict: item)
                        result.append(model)
                    }
                    completion(result)
                    PersistenceManager.sharedInstance.parseJsonData(input: json)
                    UserDefaults.standard.set(true, forKey: "previouslyLaunched")
                }
                
            case .failure(let error):
                print(error)
            }
            
            
        }
    }
}
