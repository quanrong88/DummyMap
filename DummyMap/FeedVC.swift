//
//  FeedVC.swift
//  DummyMap
//
//  Created by Ta Minh Quan on 02/12/2017.
//  Copyright © 2017 Ta Minh Quan. All rights reserved.
//

import UIKit
import Alamofire
import PKHUD
import Cosmos
import CoreData

class FeedVC: UIViewController {

    @IBOutlet weak var feedCollectionView: UICollectionView!
    
    var feedData: [FeedViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedCollectionView.register(DemoCell.nib, forCellWithReuseIdentifier: DemoCell.identifier)
        DataManager.shareInstance.loadData(completion: { [unowned self] (restaurantModel) in
            for model in restaurantModel {
                let viewModel = FeedViewModel(dataModel: model)
                self.feedData.append(viewModel)
            }
            self.feedCollectionView.reloadData()
        })
        
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        feedCollectionView.collectionViewLayout.invalidateLayout()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail", let desVC = segue.destination as? RestaurantDetailVC, let content = sender as? RestaurantDataModel {
            desVC.restaurant = DetailViewModel(dataModel: content)
        }
    }
    
    @IBAction func refreshBtnClicked(_ sender: UIBarButtonItem) {
        HUD.show(.progress)
        DataManager.shareInstance.reloadData(completion: {(restaurantModel) in
            self.feedData.removeAll()
            for model in restaurantModel {
                let viewModel = FeedViewModel(dataModel: model)
                self.feedData.append(viewModel)
            }
            self.feedCollectionView.reloadData()
            HUD.hide()
        })
    }
    

}
extension FeedVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let restaurant = DataManager.shareInstance.dataSource[indexPath.row]
        performSegue(withIdentifier: "showDetail", sender: restaurant)
    }
}

extension FeedVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DemoCell.identifier, for: indexPath) as! DemoCell
        let restaurant = feedData[indexPath.row]
        cell.titleLbl.text = restaurant.name
        cell.rateView.rating = restaurant.rate
        cell.typeIcon.image = restaurant.image
        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension FeedVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch UIDevice.current.orientation {
        case .landscapeLeft, .landscapeRight:
            return CGSize(width: collectionView.bounds.size.width / 3 , height: 150)
        default:
            return CGSize(width: collectionView.bounds.size.width, height: 60)
        }
    }
    
}
