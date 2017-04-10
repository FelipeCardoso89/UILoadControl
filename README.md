# UILoadControl

[![CI Status](http://img.shields.io/travis/FelipeCardoso89/UILoadControl.svg?style=flat)](https://travis-ci.org/FelipeCardoso89/UILoadControl)
[![Version](https://img.shields.io/cocoapods/v/UILoadControl.svg?style=flat)](http://cocoapods.org/pods/UILoadControl)
[![License](https://img.shields.io/cocoapods/l/UILoadControl.svg?style=flat)](http://cocoapods.org/pods/UILoadControl)
[![Platform](https://img.shields.io/cocoapods/p/UILoadControl.svg?style=flat)](http://cocoapods.org/pods/UILoadControl)

UILoadControl is inspired by ```UIRefreshControl ```.
It can be used to indicate data loading at the bottom of ```UITableView ``` or ```UICollectionView ```.

Check this examples:

<img src="https://github.com/FelipeCardoso89/UILoadControl/blob/master/ScreenShots/UICollectionView.gif" width="350" heigth="550">
<img src="https://github.com/FelipeCardoso89/UILoadControl/blob/master/ScreenShots/UITableView.gif" width="350" heigth="550">

By default ```UIControl``` can only be placed as ```UITableView```'s subview and it's automatically handled as ```UIRefreshControl``` and placed at its top. 

```UILoadControl``` is a subclass of ```UIControl```, placed inside a ```UIView``` (```loadControlView```) and this view is placed as a subview of ```UIScrollView```.
The ```UILoadControl``` has a ```UIScrollView``` extension (```UIScrollView_Extesnion```) that manage the ```UILoadControl```'s layout.

All ```UIScrollView``` take the hability to handle ```UILoadControl``` in its ```.loadControl``` property.

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Attach ```UILoadControl``` to any ```UIScrollView``` you want, like in the example below:
```swift

import UILoadControl

class MyViewController: UIViewController, UIScrollViewDelegate {
    
    var tableView: UITableView!
    
    //Setup loadControl on tableView
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.loadControl = UILoadControl(target: self, action: #selector(loadMore(sender:)))
        tableView.loadControl?.heightLimit = 100.0 //The default is 80.0
    }
    
    //update loadControl when user scrolls de tableView
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.loadControl?.update()
    }

    //load more tableView data
    func loadMore(sender: AnyObject?) {
        AnyAPIManager.defaultManager.giveMoreData() { (response, error) in
            //... Manage response
            self.tableView.loadControl?.endLoading() //Update UILoadControl frame to the new UIScrollView bottom.
            self.tableView.reloadData()
        }
    }
}

```
That's it!

## Requirements

XCode 7.0, iOS 8.0, Swift 3

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


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/FelipeCardoso89/uiloadcontrol/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

