# SKSwiftExtension

[![CI Status](http://img.shields.io/travis/sehkai/SKSwiftExtension.svg?style=flat)](https://travis-ci.org/sehkai/SKSwiftExtension)
<!--[![Version](https://img.shields.io/cocoapods/v/SKSwiftExtension.svg?style=flat)](http://cocoapods.org/pods/SKSwiftExtension)
[![License](https://img.shields.io/cocoapods/l/SKSwiftExtension.svg?style=flat)](http://cocoapods.org/pods/SKSwiftExtension)
[![Platform](https://img.shields.io/cocoapods/p/SKSwiftExtension.svg?style=flat)](http://cocoapods.org/pods/SKSwiftExtension) -->

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

### String

```swift
"hello world"[0..<2] //=> "he"
"hello world"[-5 ... -1] //=> "world"
"hello world".replace("World", withString: "kitty", options: ["caseSensitive": false]) //=> "hello kitty"
```

## Requirements

## Installation

SKSwiftExtension is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SKSwiftExtension", git: "git@github.com:sehkai/SKSwiftExtension.git"
```

## Author

Matthew Nguyen

## License

SKSwiftExtension is available under the MIT license. See the LICENSE file for more info.
