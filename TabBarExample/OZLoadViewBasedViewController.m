#import "OZLoadViewBasedViewController.h"


@interface OZLoadViewBasedViewController () <UIPickerViewDataSource, UIPickerViewDelegate> @end

@implementation OZLoadViewBasedViewController {
    UIPickerView *_pickerView;
}

- (NSString *)title { return @"(void)loadView"; }

- (void)loadView {
    UIView *container = [[UIView alloc] init];
    [container setBackgroundColor:[UIColor whiteColor]];
    [container setOpaque:YES];

    UIView *childContainer = [[UIView alloc] init];
    [childContainer setTranslatesAutoresizingMaskIntoConstraints:NO];
    [container addSubview:childContainer];
    [self addConstraintToView:childContainer toFillView:container];

    // picker view for selecting tabs
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    [pickerView setDataSource:self];
    [pickerView setDelegate:self];
    [pickerView setShowsSelectionIndicator:YES];
    [pickerView setBackgroundColor:[[UIColor grayColor] colorWithAlphaComponent:0.5]];
    _pickerView = pickerView;

    [pickerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [container addSubview:pickerView];
    [self addConstraintToView:_pickerView toAlignBottomInContainer:container];

    _pickerView = pickerView;
    [self setChildViewContainer:childContainer];
    [self setView:container];
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
