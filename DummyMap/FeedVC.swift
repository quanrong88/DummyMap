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

let mainURL = "https://my-json-server.typicode.com/quanrong88/Demo-repo/shops"

class FeedVC: UIViewController {

    @IBOutlet weak var feedCollectionView: UICollectionView!
    var managedContext: NSManagedObjectContext!
    var feedData: [Restaurant] = []
    let previouslyLaunched = UserDefaults.standard.bool(forKey: "previouslyLaunched")
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.coreDataStack.managedContext
        feedCollectionView.register(DemoCell.nib, forCellWithReuseIdentifier: DemoCell.identifier)
        if !previouslyLaunched {
            getRestaurantList()
        } else {
            fetchRestaurantList()
        }
        
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        feedCollectionView.collectionViewLayout.invalidateLayout()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail", let desVC = segue.destination as? RestaurantDetailVC, let content = sender as? Restaurant {
            desVC.restaurant = content
        }
    }
    
    // MARK: Ultilities function
    func getRestaurantList() {
        Alamofire.request(mainURL).responseJSON { [unowned self] response in
            switch response.result {
            case .success:
                print("Validation Successful")
                if let json = response.result.value as? [[String:Any]] {
                    self.parseJsonData(input: json)
                    UserDefaults.standard.set(true, forKey: "previouslyLaunched")
                }
                
            case .failure(let error):
                print(error)
            }
            
            
        }
    }
    func parseJsonData(input: [[String:Any]]) {
        for dict in input {
            insertNewShopEntity(dict: dict)
        }
        try! managedContext.save()
        fetchRestaurantList()
    }
    func insertNewShopEntity(dict: [String:Any]) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Restaurant",
                                                      in: managedContext) else { return }
        let restaurant = Restaurant(entity: entity, insertInto: managedContext)
        restaurant.id = dict["id"] as? String
        restaurant.name = dict["name"] as? String
        restaurant.bio = dict["bio"] as? String
        restaurant.type = dict["type"] as? String
        restaurant.rate = dict["rate"] as? Double ?? 0
        restaurant.latitude = dict["latitude"] as? Double ?? 0
        restaurant.longitude = dict["longitude"] as? Double ?? 0
    }
    func fetchRestaurantList() {
        let request = NSFetchRequest<Restaurant>(entityName: "Restaurant")
        do {
            let results = try managedContext.fetch(request)
            feedData = results
            feedCollectionView.reloadData()
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }

}
extension FeedVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let restaurant = feedData[indexPath.row]
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
        if let type = restaurant.type {
            cell.setTypeIcon(type: type)
        }
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
