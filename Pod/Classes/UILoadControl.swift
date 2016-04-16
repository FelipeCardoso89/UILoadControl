//
//  UIRefreshControlBottom.swift
//  MovileRecrutamentoIOS
//
//  Created by Felipe Antonio Cardoso on 09/12/15.
//  Copyright © 2015 Felipe Antonio Cardoso. All rights reserved.
//

import UIKit
import Foundation

public class UILoadControl: UIControl {
  
  private let activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
  
  public var heightLimit: CGFloat = 80.0
  public private (set) var loading: Bool = false
  
  var scrollView: UIScrollView = UIScrollView()
  
  override public var frame: CGRect {
    didSet{
      if (frame.size.height > heightLimit) && !loading {
        self.sendActionsForControlEvents(UIControlEvents.ValueChanged)
      }
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.initialize()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.initialize()
  }
  
  override public func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override public func layoutSubviews() {
    super.layoutSubviews()
  }

  /*
  Update layout at finsih to load
  */
  public func endLoading(){
    setLoading(false)
    fixPosition()
  }
  
}

extension UILoadControl {
  
  /*
  Initilize the control
  */
  private func initialize(){
    setupActivityIndicator()
    self.reloadTargetsIfNedeed()
  }
  
  
  /*
  Make sure that the trigger target is active
  */
  private func reloadTargetsIfNedeed() {
    let selectorName: Selector = #selector(UILoadControl.didValueChange(_:))
    if self.actionsForTarget(self, forControlEvent: UIControlEvents.ValueChanged) == nil {
      self.addTarget(self, action: selectorName, forControlEvents: UIControlEvents.ValueChanged)
    }
  }
  
  
  /*
  Check if the control frame should be updated.
  This method is called after user hits the end of the scrollView
  */
  func updateUI(){
    if self.scrollView.contentSize.height < self.scrollView.bounds.size.height {
      return
    }
    
    let contentOffSetBottom = max(0, ((scrollView.contentOffset.y + scrollView.frame.size.height) - scrollView.contentSize.height))
    if (contentOffSetBottom >= 0 && !loading) || (contentOffSetBottom >= heightLimit && loading) {
      self.updateFrame(CGRectMake(0.0, scrollView.contentSize.height, scrollView.frame.size.width, contentOffSetBottom))
    }
  }
  
  /*
  Update layout after user scroll the scrollView
  */
  private func updateFrame(rect: CGRect){
    guard let superview = self.superview else {
      return
    }
    
    superview.frame = rect
    frame = superview.bounds
    activityIndicatorView.alpha = (((frame.size.height * 100) / heightLimit) / 100)
    activityIndicatorView.center = CGPointMake((frame.size.width / 2), (frame.size.height / 2))
  }
  
  /*
  Place control at the scrollView bottom
  */
  private func fixPosition(){
    self.updateFrame(CGRectMake(0.0, scrollView.contentSize.height, scrollView.frame.size.width, 0.0))
  }
  
  /*
  Set layout to a "loading" or "not loading" state
  */
  private func setLoading(isLoading: Bool){
    loading = isLoading
    dispatch_async(dispatch_get_main_queue()) { [unowned self] in
      
      var contentInset = self.scrollView.contentInset
      
      if self.loading {
        contentInset.bottom = self.heightLimit
        self.activityIndicatorView.startAnimating()
      }else{
        contentInset.bottom = 0.0
        self.activityIndicatorView.stopAnimating()
      }
      
      self.scrollView.contentInset = contentInset
    }
  }
  
  /*
  Prepare activityIndicator
  */
  private func setupActivityIndicator(){
    
    self.activityIndicatorView.hidesWhenStopped = false
    self.activityIndicatorView.color = UIColor.darkGrayColor()
    self.activityIndicatorView.transform = CGAffineTransformMakeScale(1.4, 1.4)
    
    addSubview(self.activityIndicatorView)
    bringSubviewToFront(self.activityIndicatorView)
  }
  
  @objc private func didValueChange(sender: AnyObject?){
    setLoading(true)
  }
  
}
