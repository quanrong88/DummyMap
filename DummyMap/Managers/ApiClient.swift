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
    
    class func getRestaurantList(completion: @escaping ([RestaurantDataModel]) -> Void) {
        Alamofire.request(mainURL).responseJSON { response in
            switch response.result {
            case .success:
                print("Validation Successful")
                if let json = response.result.value as? [[String:Any]] {
                    var result: [RestaurantDataModel] = []
                    for item in json {
                        let model = RestaurantDataModel(dict: item)
                        result.append(model)
                    }
                    completion(result)
                    PersistenceManager.parseJsonData(input: json)
                    UserDefaults.standard.set(true, forKey: "previouslyLaunched")
                }
                
            case .failure(let error):
                print(error)
            }
            
            
        }
    }
}
