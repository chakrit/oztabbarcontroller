#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface OZTabBarController : UIViewController

@property (nonatomic, strong, readonly) NSArray *viewControllers;
@property (nonatomic, strong) IBOutlet UIView *childViewContainer;

@property (nonatomic, strong) UIViewController *selectedViewController;
@property (nonatomic) NSUInteger selectedTabIndex;
@property (nonatomic) NSInteger tagOffset;

- (id)initWithViewControllers:(NSArray *)viewControllers;
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
      viewControllers:(NSArray *)viewControllers;

- (IBAction)userDidTapTabButton:(id)sender;
- (void)setActiveTab:(NSUInteger)tabIndex;

@end
