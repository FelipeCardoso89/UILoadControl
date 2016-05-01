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
    
    clvItem.loadControl = UILoadControl(target: self, action: "loadMore:")
    clvItem.loadControl?.heightLimit = 50.0 //The default is 80.0
    clvItem.delegate = self
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @objc private func loadMore(sender: AnyObject?) {
    let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(loadDelaySeg * Double(NSEC_PER_SEC)))
    dispatch_after(delayTime, dispatch_get_main_queue()) {
      self.numberOfItems += self.numberOfItems
      self.clvItem.loadControl!.endLoading()
      self.clvItem.reloadData()
    }
  }
}

extension FirstViewController: UICollectionViewDataSource, UICollectionViewDelegate {

  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return numberOfItems
  }
 
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell: UICustomCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("UICustomCollectionViewCell", forIndexPath: indexPath) as!UICustomCollectionViewCell
    cell.cellLabel.text = String("\(indexPath.item)")
    return cell
  }
  
}

extension FirstViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(scrollView: UIScrollView) {
    scrollView.loadControl?.update()
  }
}