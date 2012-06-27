//
//  OZChildViewController.m
//  TabBarExample
//
//  Created by Chakrit Wichian on 6/27/12.
//  Copyright (c) 2012 Oozou Ltd. All rights reserved.
//

#import "OZChildViewController.h"


@implementation OZChildViewController

- (id)initWithTitle:(NSString *)title {
    if (self = [super initWithNibName:nil bundle:nil]) {
        [self setTitle:title];
    }
    return self;
}

- (void)loadView {
    CGRect frame = CGRectMake(10, 10, 300, 100);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    [label setFont:[UIFont fontWithName:@"Courier" size:24.0]];
    [label setText:[self title]];
    
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [view addSubview:label];
    [self setView:view];
}

@end
