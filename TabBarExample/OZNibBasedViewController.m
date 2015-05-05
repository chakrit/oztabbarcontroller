#import "OZNibBasedViewController.h"
#import <QuartzCore/QuartzCore.h>


@implementation OZNibBasedViewController

- (NSString *)title { return @"OZNibBasedViewController.xib"; }

- (NSInteger)tagOffset {
    return 100;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // add some shadow to buttons so its more visible
    for (id btn in [[self view] subviews]) {
        if (![btn isKindOfClass:[UIButton class]]) continue;
        
        CALayer *layer = [btn layer];
        [layer setShadowColor:[[UIColor whiteColor] CGColor]];
        [layer setShadowOffset:CGSizeMake(0, 2)];
        [layer setShadowRadius:5.0];
        [layer setShadowOpacity:0.5];
    }
}

@end
