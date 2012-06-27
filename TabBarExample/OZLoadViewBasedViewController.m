//
//  OZLoadViewBasedViewController.m
//  TabBarExample
//
//  Created by Chakrit Wichian on 6/27/12.
//  Copyright (c) 2012 Oozou Ltd. All rights reserved.
//

#import "OZLoadViewBasedViewController.h"


@interface OZLoadViewBasedViewController () <UIPickerViewDataSource, UIPickerViewDelegate> @end

@implementation OZLoadViewBasedViewController {
    UIPickerView *_pickerView;
}

- (NSString *)title { return @"(void)loadView"; }

- (void)loadView {
    CGRect frame = CGRectZero;
    
    // picker view for selecting tabs
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    [pickerView setDataSource:self];
    [pickerView setDelegate:self];
    [pickerView setShowsSelectionIndicator:YES];
    
    frame = [pickerView frame];
    frame.origin.y = 460 - frame.size.height;
    [pickerView setFrame:frame];
    
    // view to display child tabs view
    frame = CGRectMake(0, 0, 320, 460 - frame.size.height);
    UIView *container = [[UIView alloc] init];
    [container setFrame:frame];
    
    self.childViewContainer = container;
    
    // main view
    frame = CGRectMake(0, 0, 320, 460);
    UIView *view = [[UIView alloc] init];
    [view setFrame:frame];
    [view addSubview:container];
    [view addSubview:pickerView];
    
    // finish
    self.childViewContainer = container;
    _pickerView = pickerView;
    
    [self setView:view];
}


#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 4;
}


#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    switch (row) {
        case 0: return @"icon_github.png";
        case 1: return @"icon_globe.png";
        case 2: return @"icon_meter.png";
        case 3: return @"icon_power.png";
    }
    
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    
    // call setSelectedTabIndex to set current visible tab
    [self setSelectedTabIndex:row];
}

@end
