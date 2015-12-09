# UILoadControl

[![CI Status](http://img.shields.io/travis/Felipe Antonio Cardoso/UILoadControl.svg?style=flat)](https://travis-ci.org/Felipe Antonio Cardoso/UILoadControl)
[![Version](https://img.shields.io/cocoapods/v/UILoadControl.svg?style=flat)](http://cocoapods.org/pods/UILoadControl)
[![License](https://img.shields.io/cocoapods/l/UILoadControl.svg?style=flat)](http://cocoapods.org/pods/UILoadControl)
[![Platform](https://img.shields.io/cocoapods/p/UILoadControl.svg?style=flat)](http://cocoapods.org/pods/UILoadControl)

UILoadControl is inspired by  ```UIRefreshControl ```.
It can be used to indicate data loading at the bottom of ```UITableView ``` or ```UICollectionView ```.

Check this examples:

![]()

![]()

By default ```UIControl``` can only be placed as ```UITableView```'s subview and are automatically handled as ```UIRefreshControl``` and placed at the its top. 

```UILoadControl``` is a subclass of ```UIControl```, place inside a ```UIView``` (```loadControlView```) and this view is placed as a subview of ```UIScrollView```.
The ```UILoadControl``` has a ```UIScrollView``` extension (```UIScrollView_Extesnion```) that manage the ```UILoadControl```'s layout.

All ```UIScrollView``` take the hability to handle ```UILoadControl``` in its ```.loadControl``` property.

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Attach ```UILoadControl``` to any ```UIScrollView``` you want, like in the example below:
```swift
import UILoadControl

override func viewDidLoad() {
    super.viewDidLoad()
    let newLoadControl = UILoadControl()
    newLoadControl.heightLimit = 100.0 //The default is 80.0
    newLoadControl.addTarget(self, action: "loadMoreData:", forControlEvents: UIControlEvents.ValueChanged)
    self.tableView.loadControl = newLoadControl
}

func loadMoreData(sender: AnyObject?) {
    //intentional Delay that represents a Network asyc call...
    let delaySeconds = 4
    let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delaySeconds * Double(NSEC_PER_SEC)))
    dispatch_after(delayTime, dispatch_get_main_queue()) {
      self.tableView.loadControl!.endLoading() //Update UILoadControl frame to the new UIScrollView bottom.
      self.tableView.reloadData()
    }
  }
}
```
That's it!

## Requirements

XCode 7.0, iOS 8.0

## Installation

UILoadControl is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod "UILoadControl"
```
## Contribution 
Please feel free to submit pull requests.

## Author
Felipe Antonio Cardoso, felipe.antonio.cardoso@gmail.com

## License

UILoadControl is available under the MIT license. See the [LICENSE](https://github.com/FelipeCardoso89/UILoadControl/blob/master/LICENSE) file for more info.
