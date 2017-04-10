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
        scrollView.loadControl = UILoadControl(target: self, action: #selector(loadMore(sender:)))
        scrollView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc private func loadMore(sender: AnyObject?) {
        DispatchQueue.main.asyncAfter(deadline: (.now() + 3.0)) {
            self.scrollView.loadControl!.endLoading()
        }
    }
    
}

extension ScrollViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.loadControl?.update()
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        print("To Top")
    }
}
