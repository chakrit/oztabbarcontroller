//
//  OZSecondChildViewController.m
//  TabBarExample
//
//  Created by Chakrit Wichian on 5/8/14.
//  Copyright (c) 2014 Oozou Ltd. All rights reserved.
//

#import "OZSecondChildViewController.h"


@implementation OZSecondChildViewController

- (void)userDidTapBack:(id)sender {
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
