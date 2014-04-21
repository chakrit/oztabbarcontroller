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
    CGRect frame = CGRectMake(0, 0, 320, 460);
    UIView *view = [[UIView alloc] initWithFrame:frame];

    // nib button
    frame = CGRectMake(10, 100, 300, 50);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"Nib-based example." forState:UIControlStateNormal];
    [button setFrame:frame];
    [button addTarget:self
               action:@selector(userDidTapNibBasedExampleButton)
     forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    // loadView button
    frame.origin.y += frame.size.height + 10;
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"loadView-based example." forState:UIControlStateNormal];
    [button setFrame:frame];
    [button addTarget:self
               action:@selector(userDidTapLoadViewBasedExampleButton)
     forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
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
