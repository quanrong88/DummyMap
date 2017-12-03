//
//  FeedVC.swift
//  DummyMap
//
//  Created by Ta Minh Quan on 02/12/2017.
//  Copyright © 2017 Ta Minh Quan. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {

    @IBOutlet weak var feedCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        feedCollectionView.register(DemoCell.nib, forCellWithReuseIdentifier: DemoCell.identifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        feedCollectionView.collectionViewLayout.invalidateLayout()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension FeedVC: UICollectionViewDelegate {
    
}

extension FeedVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DemoCell.identifier, for: indexPath)
        
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
