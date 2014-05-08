//
//  OZChildViewController.m
//  TabBarExample
//
//  Created by Chakrit Wichian on 6/27/12.
//  Copyright (c) 2012 Oozou Ltd. All rights reserved.
//

#import "OZChildViewController.h"
#import "OZSecondChildViewController.h"


@implementation OZChildViewController {
    NSString *_imageName;
}

+ (id)controllerWithImageNamed:(NSString *)imageName {
    UIViewController *controller = [[OZChildViewController alloc] initWithImageNamed:imageName];
    return [[UINavigationController alloc] initWithRootViewController:controller];
}

- (id)initWithImageNamed:(NSString *)imageName {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _imageName = [imageName copy];
    }
    return self;
}

- (void)dealloc {
    _imageName = nil;
}


- (void)userDidTapImage:(id)sender {
    UIViewController *next = [[OZSecondChildViewController alloc] init];
    [[self navigationController] pushViewController:next animated:YES];
}


- (void)loadView {
    CGRect frame = CGRectMake(10, 10, 300, 300);
    UIImage *image = [UIImage imageNamed:_imageName];

    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [imageView setUserInteractionEnabled:YES];
    [imageView setFrame:frame];

    UITapGestureRecognizer *tap = [UITapGestureRecognizer alloc];
    tap = [tap initWithTarget:self action:@selector(userDidTapImage:)];
    [imageView addGestureRecognizer:tap];

    frame = [[UIScreen mainScreen] bounds];
    UIView *view = [[UIView alloc] initWithFrame:frame];
    [view addSubview:imageView];
    [self setView:view];
}

@end
