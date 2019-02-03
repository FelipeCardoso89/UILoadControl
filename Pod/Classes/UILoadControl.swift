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
    
    private var activityIndicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .gray)
        indicatorView.hidesWhenStopped = false
        indicatorView.color = .darkGray
        indicatorView.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
        return indicatorView
    }()
    
    private var originalDelegate: UIScrollViewDelegate?
    
    public var heightLimit: CGFloat = 80.0
    public fileprivate (set) var loading: Bool = false
    
    var scrollView: UIScrollView = UIScrollView()
    
    override public var frame: CGRect {
        didSet{
            
            guard (frame.size.height > heightLimit), !loading else {
                return
            }
            
            self.setLoading(isLoading: true)
            self.sendActions(for: .valueChanged)
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
    
    public init(target: AnyObject?, action: Selector) {
        self.init()
        self.initialize()
        addTarget(target, action: action, for: .valueChanged)
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
        self.setLoading(isLoading: false)
        self.fixPosition()
    }
    
    public func update() {
        updateUI()
    }
}

extension UILoadControl {
    
    /*
     Initilize the control
     */
    fileprivate func initialize(){
        setupActivityIndicator()
    }
    
    /*
     Check if the control frame should be updated.
     This method is called after user hits the end of the scrollView
     */
    func updateUI(){
        
        guard scrollView.contentSize.height > scrollView.bounds.size.height else {
            return
        }
        
        let contentOffSetBottom = max(0, ((scrollView.contentOffset.y + scrollView.frame.size.height) - scrollView.contentSize.height))
        if (contentOffSetBottom >= 0 && !loading) || (contentOffSetBottom >= heightLimit && loading) {
            
            let newRect = CGRect(
                x:0.0,
                y: scrollView.contentSize.height,
                width: scrollView.frame.size.width,
                height: contentOffSetBottom
            )
            
            self.updateFrame(rect: newRect)
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
        activityIndicatorView.center = CGPoint(x:(frame.size.width / 2), y:(frame.size.height / 2))
    }
    
    /*
     Place control at the scrollView bottom
     */
    private func fixPosition(){
        self.updateFrame(rect: CGRect(
            x: 0.0,
            y: scrollView.contentSize.height,
            width: scrollView.frame.size.width,
            height: 0.0
        ))
    }
    
    /*
     Set layout to a "loading" or "not loading" state
     */
    private func setLoading(isLoading: Bool){
        loading = isLoading
        DispatchQueue.main.async { [weak self] in
            
            guard let strongSelf = self else {
                return
            }
            
            var contentInset = strongSelf.scrollView.contentInset
            
            if strongSelf.loading {
                contentInset.bottom = strongSelf.heightLimit
                strongSelf.activityIndicatorView.startAnimating()
            }else{
                contentInset.bottom = 0.0
                strongSelf.activityIndicatorView.stopAnimating()
            }
            
            strongSelf.scrollView.contentInset = contentInset
        }
    }
    
    /*
     Prepare activityIndicator
     */
    private func setupActivityIndicator(){
        addSubview(activityIndicatorView)
        bringSubviewToFront(activityIndicatorView)
    }
}
