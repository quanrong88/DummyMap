//
//  DemoCell.swift
//  FlexibleCollectionLandscape
//
//  Created by TaMinhQuan on 01/12/2017.
//  Copyright © 2017 TaMinhQuan. All rights reserved.
//

import UIKit
import Cosmos

class DemoCell: UICollectionViewCell {
    
    @IBOutlet weak var typeIcon: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var rateView: CosmosView!
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func moreInfoBtnClicked(_ sender: UIButton) {
        print("Show more info")
    }
    
}
