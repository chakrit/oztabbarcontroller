//
//  OZMenuViewController.m
//  TabBarExample
//
//  Created by Chakrit Wichian on 6/27/12.
//  Copyright (c) 2012 Oozou Ltd. All rights reserved.
//

#import "OZMenuViewController.h"
#import "OZChildViewController.h"
#import "OZLoadViewBasedViewController.h"
#import "OZNibBasedViewController.h"


@implementation OZMenuViewController

- (NSString *)title { return @"Menu"; }

- (void)loadView {
    UIView *view = [[UIView alloc] init];

    // nib button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"Nib-based example." forState:UIControlStateNormal];
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    [button addTarget:self
               action:@selector(userDidTapNibBasedExampleButton)
     forControlEvents:UIControlEventTouchUpInside];

    [view addSubview:button];
    [self addConstraintToView:button
        toAlignTopInContainer:view
                   topPadding:100.0];
    
    // loadView button
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"loadView-based example." forState:UIControlStateNormal];
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    [button addTarget:self
               action:@selector(userDidTapLoadViewBasedExampleButton)
     forControlEvents:UIControlEventTouchUpInside];

    [view addSubview:button];
    [self addConstraintToView:button
        toAlignTopInContainer:view
                   topPadding:160.0];

    [self setView:view];
}


- (void)userDidTapNibBasedExampleButton {
    OZNibBasedViewController *controller = nil;
    controller = [OZNibBasedViewController alloc];
    controller = [controller initWithViewControllers:[self childViewControllers]];
    
    [[self navigationController] pushViewController:controller animated:YES];
}

- (void)userDidTapLoadViewBasedExampleButton {
    OZLoadViewBasedViewController *controller = nil;
    controller = [OZLoadViewBasedViewController alloc];
    controller = [controller initWithViewControllers:[self childViewControllers]];
    
    [[self navigationController] pushViewController:controller animated:YES];
}


- (NSArray *)childViewControllers {
    return [NSArray arrayWithObjects:
            [OZChildViewController controllerWithImageNamed:@"icon_github.png"],
            [OZChildViewController controllerWithImageNamed:@"icon_globe.png"],
            [OZChildViewController controllerWithImageNamed:@"icon_meter.png"],
            [OZChildViewController controllerWithImageNamed:@"icon_power.png"], nil];
}

@end
