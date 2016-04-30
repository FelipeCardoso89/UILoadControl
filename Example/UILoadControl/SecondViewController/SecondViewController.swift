//
//  SecondViewController.swift
//  Example
//
//  Created by Felipe Antonio Cardoso on 09/12/15.
//  Copyright © 2015 Felipe Antonio Cardoso. All rights reserved.
//

import Foundation
import UIKit
import UILoadControl

class SecondViewController: UIViewController {
  
  @IBOutlet weak var tbmItem: UITableView!
  
  var numberOfItems: Int = 30
  var loadDelaySeg: Double = 4
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tbmItem.delegate = self
    tbmItem.dataSource = self
    tbmItem.loadControl = UILoadControl(target: self, action: #selector(SecondViewController.loadMore(_:)))
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @objc private func loadMore(sender: AnyObject?) {
    let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(loadDelaySeg * Double(NSEC_PER_SEC)))
    dispatch_after(delayTime, dispatch_get_main_queue()) {
      self.numberOfItems += self.numberOfItems
      self.tbmItem.loadControl!.endLoading()
      self.tbmItem.reloadData()
    }
  }
}

extension SecondViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return numberOfItems
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath)
    cell.textLabel!.text = String("\(indexPath.item)")
    return cell
  }
  
}

extension SecondViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(scrollView: UIScrollView) {
    scrollView.loadControl?.update()
  }
}