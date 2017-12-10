//
//  RestaurantDetailVC.swift
//  DummyMap
//
//  Created by TaMinhQuan on 04/12/2017.
//  Copyright © 2017 Ta Minh Quan. All rights reserved.
//

import UIKit
import Cosmos

class RestaurantDetailVC: UIViewController {

    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var bgImg: UIImageView!
    var restaurant: RestaurantDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let input = restaurant {
            bindingUI(input: input)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: Ultilities function
    func bindingUI(input: RestaurantDataModel) {
        nameLbl.text = input.name
        ratingView.rating = input.rate
        bioTextView.text = input.bio
        switch input.type {
        case .hawk:
            bgImg.image = #imageLiteral(resourceName: "hawk-bg")
            break
        case .coffee:
            bgImg.image = #imageLiteral(resourceName: "coffee-bg")
            break
        case .fastfood:
            bgImg.image = #imageLiteral(resourceName: "fastfood-bg")
            break
        case .streettea:
            bgImg.image = #imageLiteral(resourceName: "streettea-bg")
            break
        default:
            break
        }
        
    }

}
