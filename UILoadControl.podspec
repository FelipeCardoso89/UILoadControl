#
# Be sure to run `pod lib lint UILoadControl.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "UILoadControl"
  s.version          = "1.0.0"
  s.summary          = "Add a PushToLoad control to any UIScrollView, UICollectionView or UITableView"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC

UILoadControl is like UIRefreshControl, but its placed at the bottom of any UIScrollView.
The UILoadControl can be used as a trigger to load next page of a paginated UICollectionView or UITableView.

                      DESC

  s.homepage         = "https://github.com/FelipeCardoso89/UILoadControl"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Felipe Antonio Cardoso" => "felipe.antonio.cardoso@gmail.com" }
  s.source           = { :git => "https://github.com/FelipeCardoso89/UILoadControl.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/FelipeCardoso89'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.frameworks = 'UIKit', 'Foundation'


end