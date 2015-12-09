//
//  UILoadControl+UIScrollView.swift
//  UILoadControlDemo
//
//  Created by Felipe Antonio Cardoso on 09/12/15.
//  Copyright © 2015 Felipe Antonio Cardoso. All rights reserved.
//

import UIKit
import Foundation

extension UIScrollView {
  
  /*
  Add new variables to UIScrollView class
  
  UIControls can only be placed as subviews of UITableView.
  So we had to place UILoadControl inside a UIView "loadControlView" and place "loadControlView" as a subview of UIScrollView.
  */
  
  private struct AssociatedKeys {
    static var loadControl: UILoadControl?
    private static var loadControlView: UIView?
  }
  
  /*
  UILoadControl object
  */
  public var loadControl: UILoadControl? {
    get {
      return objc_getAssociatedObject(self, &AssociatedKeys.loadControl) as? UILoadControl
    }
    
    set {
      if let newValue = newValue {
        objc_setAssociatedObject(self, &AssociatedKeys.loadControl, newValue as UILoadControl?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        self.showRefreshControlBottomIfNeeded()
      }
    }
  }
  
  /*
  UILoadControl view container
  */
  private var loadControlView: UIView? {
    get {
      return objc_getAssociatedObject(self, &AssociatedKeys.loadControlView) as? UIView
    }
    
    set {
      if let newValue = newValue {
        objc_setAssociatedObject(self, &AssociatedKeys.loadControlView, newValue as UIView?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      }
    }
  }
}

extension UIScrollView: UIScrollViewDelegate {
  
  /*
  Attention: You must call super.scrollViewDidScroll if you override scrollViewDidScroll
  */
  public func scrollViewDidScroll(scrollView: UIScrollView) {
    guard let loadControl = self.loadControl else {
      return
    }
    
    loadControl.updateUI()
  }
}

extension UIScrollView {
  
  /*
  Place UILoadControl if its not in the scrollView
  */
  private func showRefreshControlBottomIfNeeded(){
    
    guard let loadControl = self.loadControl else {
      return
    }
    
    self.delegate = self
    loadControl.scrollView = self
    
    if self.loadControlView == nil {
      let loadControlView = UIView()
      loadControlView.clipsToBounds = true
      loadControlView.addSubview(loadControl)
      addSubview(loadControlView)
      self.loadControlView = loadControlView
    }
  }
}
