OZTabBarController
==================

A lightweight tab bar controller geared for maximum customizability. It simply handles the job of switching views and leave everything else for you to customize. Supports using a NIB file to create the main view.

## Features:

* Support both nib-based mode and `loadView`-based mode within a single class.
* Doesn't impose any kinds of graphics on your application. Roll your own graphics and animations and just send a signal using standard `IBAction` hooks or a single super method call.
* Automatically handles navigation bar property changes when the user switches tab if and when this controller is used inside a `UINavigationController`
* Also handles child `UINavigationController` in tabs as well by automatically calling `popToRootViewController` on multiple taps

## Usage:

CocoaPods: `pod 'OZTabBarController', '~> 0.2.0'`

### Nib-based

Use the `initWithViewControllers:` method or use the designated intializer `initWithNibName:bundle:viewControllers:` to create a tab view with the specified view controllers and load view form the specified NIB file.

Or just extends the `OZTabBarController` class directly and add a NIB file with the same name to your project.

The NIB file should have these connections:
* The standard `view` property for the view controller.
* The `childViewContainer` property should be connected to a `UIView` that will be used to place child tab's views.
* `userDidTapTabButton` action should be connected from a `UIControl` which should triggers the respective tab displays. Set the `tag` property to index of the tab you wish to display after clicking the button (or whatever action you have wired for your control.)

### Tag offsets

Because tab indexes are zero-based and you might need to use view tags for other purposes, `OZTabBarController` now supports a `tagOffset` property. You can override this property to specify the number the controller should subtracts from the view tag to obtain the tab index.

For example, if you have your tab buttons' tags set to 100, 101, 102, .. you can set `tagOffset` to 100 by placing the following override block on your `ViewControler.m` file:

    - (NSInteger)tagOffset {
          return 100;
    }

or simply place `self.tagOffset = 100` in your subclass's init method.

### loadView-based

If you don't use interface builder and just build your views from `loadView` just make sure:

* That you call the designated initializer, which is `initWithNibName:bundle:viewControllers:`
* That you have set the `childViewContainer` property to a `UIView` instance to which the child tab view should be put to display.
* That you call either `setSelectedTabIndex` or `setSelectedViewControler` to display the tab as needed.

## iOS 7 notes

If you are using `OZTabBarController` inside a `UINavigationController` and find that the
view extends underneath the navigation bar, you can override the following method to
prevent this behavior.

```objective-c
- (UIRectEdge)edgesForExtendedLayout {
  return UIRectEdgeNone;
}
```

Or use the respective setter to set the value as early as possible in your view controller
lifecycle.

Refer to [this SO question](http://stackoverflow.com/q/18294872/3055) for more information.

## License:

BSD2 (See LICENSE file for details)

