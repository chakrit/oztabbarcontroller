//
//  OZChildViewController.m
//  TabBarExample
//
//  Created by Chakrit Wichian on 6/27/12.
//  Copyright (c) 2012 Oozou Ltd. All rights reserved.
//

#import "OZChildViewController.h"


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


- (void)loadView {
    CGRect frame = CGRectMake(10, 10, 300, 300);
    UIImage *image = [UIImage imageNamed:_imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [imageView setFrame:frame];

    frame = [[UIScreen mainScreen] bounds];
    UIView *view = [[UIView alloc] initWithFrame:frame];
    [view addSubview:imageView];
    [self setView:view];
}

@end
