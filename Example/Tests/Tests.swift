// https://github.com/Quick/Quick

import Quick
import Nimble
import UILoadControl

class LayoutSpec: QuickSpec {

  override func spec() {
    describe("Teste UILoadControl Layouts") { () -> () in
    
      it("Fixed position") {
        let control = UILoadControl()
        control.endLoading()
        expect(control.frame.size.height) == 0.0
      }
      
    }
  }
}

class ComponetsSpec: QuickSpec {
  
  override func spec() {
    describe("Test UILoadControl componets setup") { () -> () in
      
      it("Did setup targets") {
        let control = UILoadControl()
        expect(control.actionsForTarget(control, forControlEvent: UIControlEvents.ValueChanged)) != nil
      }
      
    }
  }
}