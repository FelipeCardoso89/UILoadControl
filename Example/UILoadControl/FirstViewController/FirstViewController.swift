//
//  FirstViewController.swift
//  Example
//
//  Created by Felipe Antonio Cardoso on 09/12/15.
//  Copyright © 2015 Felipe Antonio Cardoso. All rights reserved.
//

import UIKit
import Foundation
import UILoadControl

class FirstViewController: UIViewController {
  
  @IBOutlet weak var clvItem: UICollectionView!
  
  var numberOfItems: Int = 20
  var loadDelaySeg: Double = 4
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    clvItem.delegate = self
    clvItem.dataSource = self
    
    clvItem.loadControl = UILoadControl(target: self, action: #selector(loadMore(sender:)))
    clvItem.loadControl?.heightLimit = 50.0 //The default is 80.0
    clvItem.delegate = self
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @objc private func loadMore(sender: AnyObject?) {
    DispatchQueue.main.asyncAfter(deadline: (.now() + 3.0)) {
        self.numberOfItems += self.numberOfItems
        self.clvItem.loadControl!.endLoading()
        self.clvItem.reloadData()
    }
  }
}

extension FirstViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICustomCollectionViewCell", for: indexPath) as! UICustomCollectionViewCell
        cell.cellLabel.text = String("\(indexPath.item)")
        return cell
    }
  
}

extension FirstViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.loadControl?.update()
    }
    
}
