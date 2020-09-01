<p align="center">
<img src="https://github.com/jwd-ali/Switches/blob/master/SwitchesDemo/Resources/Assets.xcassets/switch-animation-post.imageset/switch-animation-post.jpg">
  </p>
<img align="right" src="https://github.com/jwd-ali/Switches/blob/master/images/Screen%20Recording%202020-08-31%20at%203.39.54%20PM.gif"  height = "580"/>

# Switches Animations
> An animated switch collection


[![CI Status](https://travis-ci.org/jwd-ali/RingPieChart.svg)](https://travis-ci.org/jwd-ali/RingPieChart)
[![CocoaPods Version](https://img.shields.io/cocoapods/v/RingPieChart.svg?style=flat)](https://cocoapods.org/pods/RingPieChart)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-0473B3.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/RingPieChart.svg?style=flat)](https://cocoapods.org/pods/RingPieChart)
[![Platform](https://img.shields.io/cocoapods/p/RingPieChart.svg?style=flat)](https://cocoapods.org/pods/RingPieChart)
[![Swift 5.1](https://img.shields.io/badge/swift-5.1-orange)](https://swift.org)

<p><h4>Add Beautiful Customise Switch in your application to enhance your application UI and UX</h4></p>

___


<p>
From time to time I browse Dribbble to get inspiration from UI/UX designers. You often see non-native control elements in these designs. Some, such as checkboxes, have no native counterpart in UIKit while others like switches are— except they’re nearly impossible to customize. You cannot even change the size of a UISwitch. What if you need to implement a completely custom designed switch for your app like this one


If you wanted to implement any of these designs it would be a poor choice to subclass `UISwitch` as you can hardly customize the colours — aside from the on/off tint.
So I thought I would try to re-engineer the UISwitch so that I would have complete control over each aspect, making it easy to style in the future.Turns out its actually pretty easy (and a lot of fun!) to build these control elements from scratch. I even went so far as to add the ability to set on/off text or images. For those who don’t know, UISwitch has onImage and offImage which when set don’t do anything anymore.

So i take few of the Dribble switches Daily UI challenges as challenge and implemented them in this library.This library has cool and sophisticated animations,Designs and effects. Also, customizable properties can be tweaked behaviors and enhance your application UI cool. With this library, you can easily implement material design switch to your app.
</p>

> You can play with the attributes and can customise them according to your UI demands. Below are the few examples
## Usage example

|Class|Example|
|-|  --------  |
|Switcher|<img src="https://static.dribbble.com/users/108183/screenshots/4148855/switcher_xxxiii_by_volorf_.gif" style="height:300;width:300"> Dribble UI Challenge: https://dribbble.com/shots/4148855-Switcher-XXXIII|  
|SwitcherFullStrtech|<img src="https://static.dribbble.com/users/108183/screenshots/3844909/switcher_on_off.gif" style="height:300;width:300">Dribble UI Challenge:https://dribbble.com/shots/3844909-On-Off|  
|SDSwitch|<img src="https://static.dribbble.com/users/106600/screenshots/3545882/bankin-switch-servercall_2x.gif" style="height:200;width:auto"> Dribble UI Challenge:https://dribbble.com/shots/3545882-Switch-with-server-calls|  
|YapDarkAndLightModeSwitch |<img src="https://static.dribbble.com/users/301508/screenshots/2484722/daily_ui_day_15_on_off_switch.gif" style="height:200;width:auto"> Dribble UI Challenge:https://dribbble.com/shots/2484722-Daily-Ui-Day-15-On-Off-Switch|  
|YapAnimatedSwitch|<img src="https://static.dribbble.com/users/45534/screenshots/2309834/5.gif" style="height:200;width:auto"> Dribble UI Challenge:https://dribbble.com/shots/2309834-Yet-another-toggle-animation|  
|SDSwitch |<img src="https://static.dribbble.com/users/2494961/screenshots/5192899/toggle-1.gif" style="height:200;width:auto">Dribble UI Challenge:https://dribbble.com/shots/5192899-Simple-toggle| 
|YapFullTextSwitch |<img src="https://static.dribbble.com/users/26878/screenshots/2330566/switchblue.gif" style="height:200;width:auto"> Dribble UI Challenge:https://dribbble.com/shots/2330566-Morph-Switch| 
|JDSwitch |<img src="https://static.dribbble.com/users/108183/screenshots/2346044/switch.gif" style="height:200;width:auto"> Dribble UI Challenge:https://dribbble.com/shots/2346044-Switch-on-off| 
|YapSmileSwitch |<img src="https://static.dribbble.com/users/108183/screenshots/2011284/switcher-ll.gif" style="height:200;width:auto"> Dribble UI Challenge:https://dribbble.com/shots/2011284-Switcher-ll| 
|YapLiquidSwitch |<img src="https://static.dribbble.com/users/108183/screenshots/2028065/switcher-lll.gif" style="height:200;width:auto"> Dribble UI Challenge:https://dribbble.com/shots/2028065-Switcher-lll| 
|YapSwitchSlim |<img src="https://static.dribbble.com/users/153131/screenshots/2158763/toggle.gif" style="height:200;width:auto"> Dribble UI Challenge:https://dribbble.com/shots/2158763-simple-toggle| 
|YapGradientSwitch |<img src="https://static.dribbble.com/users/1020708/screenshots/2603107/015_dribbble.gif" style="height:200;width:auto"> Dribble UI Challenge:https://dribbble.com/shots/2603107-toggle-switch-micro-interaction| 
|YapHalfStretchSwitch |<img src="https://github.com/jwd-ali/Switch-Animations/blob/master/images/ezgif.com-video-to-gif-23.gif" style="height:200;width:auto">| 
|YapSwitch |<img src="https://github.com/jwd-ali/Switch-Animations/blob/master/images/ezgif.com-video-to-gif-24.gif" style="height:200;width:auto">|
|YapFullStretchSwitch |<img src="https://github.com/jwd-ali/Switch-Animations/blob/master/images/ezgif.com-video-to-gif-25.gif" style="height:200;width:auto">|
|YapSwitch |<img src="https://github.com/jwd-ali/Switch-Animations/blob/master/images/ezgif.com-video-to-gif-26.gif" style="height:200;width:auto">|

## Requirements

- iOS 10.0+ / Mac OS X 10.9+ / watchOS 2.0+ / tvOS 9.0+
- Xcode 8.0+

## Installation

### [CocoaPods](http://cocoapods.org)

To integrate **Switches Animations** into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
use_frameworks!

pod 'Switches'
```

Then, run the following command:

```bash
$ pod install
```

### [Swift Package Manager (SPM)](https://swift.org/package-manager)

#### Prerequisites
- OSX


#### Update `Package.swift`
To integrate `Switches Animations` in your project, add the proper description to your `Package.swift` file:
```swift
// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "YOUR_PROJECT_NAME",
    dependencies: [
        .package(url: "https://github.com/jwd-ali/Switch-Animations.git")
    ],
    targets: [
        .target(
            name: "YOUR_TARGET_NAME",
            dependencies: ["Switch-Animations"]
        ),
        ...
    ]
)
```

  
### [Carthage](http://github.com/Carthage/Carthage)

To integrate `Switches Animations` into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "jwd-ali/Switch-Animations"
```
### Manually

If you prefer not to use a dependency manager, you can integrate Switches Animations into your project manually.

- Add Sources folder into your project

## Integration
See the Demo Xcode project its easy to understand with proper comments on properties .. write me if you didn't get anything L060214@gmail.com

<h4>Be careful!!!</h4>
Irreversible consequences are possible during long work with the framework.


<img src="https://raw.githubusercontent.com/d-dotsenko/DDAnimatedSwitch/master/Info/jimThumb.gif" width=500>


## Contributing

I’d love to have help on this project. For small changes please [open a pull request](https://github.com/jwd-ali/Switch-Animations/pulls), for larger changes please [open an issue](https://github.com/jwd-ali/Switch-Animations/issues) first to discuss what you’d like to see.


License
-------

Switch-Animations is under [MIT](https://opensource.org/licenses/MIT). See [LICENSE](LICENSE) file for more info.
