//
//  ScrollViewController.swift
//  UILoadControl
//
//  Created by Felipe Antonio Cardoso on 16/04/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import UILoadControl

class ScrollViewController: UIViewController {
  
  @IBOutlet weak var scrollView: UIScrollView!
  
  var loadDelaySeg: Double = 2
  
  override func viewDidLoad() {
    super.viewDidLoad()
    scrollView.loadControl = UILoadControl(target: self, action: #selector(ScrollViewController.loadMore(_:)))
    scrollView.delegate = self
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  @objc private func loadMore(sender: AnyObject?) {
    let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(loadDelaySeg * Double(NSEC_PER_SEC)))
    dispatch_after(delayTime, dispatch_get_main_queue()) {
      self.scrollView.loadControl!.endLoading()
    }
  }
  
}

extension ScrollViewController: UIScrollViewDelegate {
  
  func scrollViewDidScroll(scrollView: UIScrollView) {
    scrollView.loadControl?.update()
  }
  
  
  func scrollViewDidScrollToTop(scrollView: UIScrollView) {
    print("To Top")
  }
}
