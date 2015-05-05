#import "OZSecondChildViewController.h"


@implementation OZSecondChildViewController

- (void)userDidTapBack:(id)sender {
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
