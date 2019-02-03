//
//  Object+Extensions.swift
//  Pods-UILoadControl_Example
//
//  Created by Henrique Cardoso on 03/02/2019.
//

import Foundation


extension UIView {
    
    public func swizzleMethod(from original: Selector, with method: Selector) {

        guard let thisClass = object_getClass(self) else {
            return
        }
        
        guard
            let originalMethod: Method = class_getInstanceMethod(thisClass, original),
            let newMethod: Method = class_getInstanceMethod(thisClass, method)
        else {
            return
        }
        
        if class_addMethod(thisClass, original, method_getImplementation(newMethod), method_getTypeEncoding(newMethod)) {
            class_replaceMethod(thisClass, method, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, newMethod)
        }
    }
}
