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
    var restaurant: DetailViewModel?
    
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
    func bindingUI(input: DetailViewModel) {
        nameLbl.text = input.name
        ratingView.rating = input.rate
        bioTextView.text = input.bio
        bgImg.image = input.backGround
        
    }

}
