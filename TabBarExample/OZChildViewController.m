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
    return [[OZChildViewController alloc] initWithImageNamed:imageName];
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


- (void)willMoveToParentViewController:(UIViewController *)parent {
}

- (void)didMoveToParentViewController:(UIViewController *)parent {
}


- (void)loadView {
    UIImage *image = [UIImage imageNamed:_imageName];

    UIView *container = [[UIView alloc] init];
    [container setTranslatesAutoresizingMaskIntoConstraints:NO];

    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [imageView setUserInteractionEnabled:YES];

    UITapGestureRecognizer *tap = [UITapGestureRecognizer alloc];
    tap = [tap initWithTarget:self action:@selector(userDidTapImage:)];
    [imageView addGestureRecognizer:tap];

    [container addSubview:imageView];
    [self addConstraintToView:imageView toCenterInContainer:container];

    [self setView:container];
}

@end
