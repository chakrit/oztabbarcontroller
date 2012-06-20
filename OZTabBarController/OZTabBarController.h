//
//  OZTabBarController.h
//  OZTabBarController
//
//  Created by Chakrit Wichian on 6/20/12.
//  Copyright (c) 2012 Oozou Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface OZTabBarController : UIViewController

@property (nonatomic, strong, readonly) NSArray *viewControllers;
@property (nonatomic, strong) IBOutlet UIView *viewContainer;

@property (nonatomic, strong) UIViewController *selectedViewController;
@property (nonatomic) NSUInteger selectedTabIndex;

- (id)initWithViewControllers:(NSArray *)viewControllers;
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
      viewControllers:(NSArray *)viewControllers;

- (IBAction)userDidTapTabButton:(id)sender;
- (void)setActiveTab:(NSUInteger)tabIndex;

@end
