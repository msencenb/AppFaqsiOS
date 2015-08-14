# AppFaqs

[![CI Status](http://img.shields.io/travis/Matt Sencenbaugh/AppFaqs.svg?style=flat)](https://travis-ci.org/Matt Sencenbaugh/AppFaqs)
[![Version](https://img.shields.io/cocoapods/v/AppFaqs.svg?style=flat)](http://cocoapods.org/pods/AppFaqs)
[![License](https://img.shields.io/cocoapods/l/AppFaqs.svg?style=flat)](http://cocoapods.org/pods/AppFaqs)
[![Platform](https://img.shields.io/cocoapods/p/AppFaqs.svg?style=flat)](http://cocoapods.org/pods/AppFaqs)

## Installation

This iOS SDK is meant to be used in conjunction with a subscription at [https://appfaqs.co"](https://appfaqs.co).

Step 1) Add AppFaqs to your project via [CocoaPods](http://cocoapods.org) by adding the following to your Podfile:

```ruby
pod "AppFaqs"
```
Step 2) Import AppFaqs and make sure the view controller AppFaqs will be presented from conforms to the APFDelegate 

```objective-c
#import <AppFaqs/APFaqs.h>
@import UIKit;

@interface APFViewController : UIViewController<APFDelegate>

@end
```

Step 3) Show the FAQ screen and ensure you have implemented the delegate callback

```objective-c
- (IBAction)launchFAQPressed:(id)sender {
    UIViewController *viewController = [APFaqs faqWithApiKey:@"YOURAPIKEYHERE" withDelegate:self];
    [self presentViewController:viewController animated:YES completion:^{}];
}

#pragma mark - APFDelegate
-(void)closeButtonWasPressed {
    [self dismissViewControllerAnimated:YES completion:^{}];
}
```

Step 4) Grin broadly from ear to ear, drink a beer, put a sock on your nose, or whatever it is you do to celebrate! If you need help
with the installation please email support@appfaqs.co

## Example Project

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

iOS8+

## Author

Matt Sencenbaugh, matt.sencenbaugh@gmail.com

## License

AppFaqs is available under the MIT license. See the LICENSE file for more info.
