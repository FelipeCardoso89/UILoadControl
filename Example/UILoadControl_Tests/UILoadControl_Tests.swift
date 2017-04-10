//
//  UILoadControl_Tests.swift
//  UILoadControl_Tests
//
//  Created by Felipe Antonio Cardoso on 16/04/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
import UILoadControl

class UILoadControl_Tests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testLayout() {
    let control = UILoadControl()
    control.endLoading()
    XCTAssertEqual(control.frame.size.height, 0.0)
  }

  func testActionTarget() {
    let control = UILoadControl()
    XCTAssertNotNil(control.actions(forTarget: control, forControlEvent: UIControlEvents.valueChanged))
  }
}
