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
  
  @IBOutlet weak var tblItem: UITableView!
  
  var numberOfItems: Int = 30
  var loadDelaySeg: Double = 4
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tblItem.delegate = self
    tblItem.dataSource = self
    tblItem.loadControl = UILoadControl(target: self, action: #selector(loadMore(sender:)))
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @objc private func loadMore(sender: AnyObject?) {
    DispatchQueue.main.asyncAfter(deadline: (.now() + 3.0)) {
        self.numberOfItems += self.numberOfItems
        self.tblItem.loadControl!.endLoading()
        self.tblItem.reloadData()
    }
  }
}

extension SecondViewController: UITableViewDataSource, UITableViewDelegate {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItems
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        cell.textLabel!.text = String("\(indexPath.item)")
        return cell
    }
  
}

extension SecondViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.loadControl?.update()
    }
    
}
