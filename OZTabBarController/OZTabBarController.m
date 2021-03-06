#import "OZTabBarController.h"


@implementation OZTabBarController {
    NSUInteger _selectedTabIndex;
    UIControl *_selectedTabControl;
    UIView *_childViewContainer;
    UIViewController *_selectedViewController;

    NSArray *_contentViewConstraints;
    BOOL _navigationItemAttached;
}


#pragma mark - Initializers

- (id)init {
    return [self initWithNibName:nil
                          bundle:nil
                 viewControllers:[NSArray array]];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    return [self initWithNibName:nibNameOrNil
                          bundle:nibBundleOrNil
                 viewControllers:[NSArray array]];
}

- (id)initWithViewControllers:(NSArray *)viewControllers {
    return [self initWithNibName:nil
                          bundle:nil
                 viewControllers:viewControllers];
}

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
      viewControllers:(NSArray *)viewControllers {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        _viewControllers = [NSArray arrayWithArray:viewControllers];
        _tagOffset = 0;
        [self didInit];
    }
    return self;
}

- (void)didInit {
    _selectedViewController = nil;
    _selectedTabControl = nil;
    _selectedTabIndex = -1;
    _navigationItemAttached = NO;
}

- (void)dealloc {
    [self detachNavigationItem];
    
    _selectedViewController = nil;
    _selectedTabControl = nil;
    
    _viewControllers = nil;
    _childViewContainer = nil;
}


// NOTE: For iOS 7 layouts that must not extend underneath the navigation bar, add the following
//   method override (or call the setter as early as possible.)
//
//   - (UIRectEdge)edgesForExtendedLayout { return UIRectEdgeNone; }
//
// REF: http://stackoverflow.com/questions/18294872/ios-7-status-bar-back-to-ios-6-default-style-in-iphone-app/18855464#18855464


#pragma mark - View events

- (void)viewDidLoad {
    [super viewDidLoad];

    // warn if child view container not set (should be set during loadView() or init())
    if (!_childViewContainer) {
        NSLog(@"OZTabBarController.childViewContainer not set before viewDidLoad()");
    }

    // select first view (and attachNavigationItem)
    UIView *firstTab = [[self view] viewWithTag:self.tagOffset + 0];
    if ([firstTab isKindOfClass:[UIControl class]]) { // using nib-based approach
        [self userDidTapTabButton:firstTab];

    } else { // using loadView approach
        [self setActiveTab:0];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self detachNavigationItem];
}


- (void)attachNavigationItem {
    if (_navigationItemAttached) return;
    
    [self childNavigationItemDidChange];
    
    UINavigationItem *childItem = [_selectedViewController navigationItem];    
    [childItem addObserver:self
                forKeyPath:@"leftBarButtonItem"
                   options:NSKeyValueObservingOptionInitial
                   context:nil];
    [childItem addObserver:self
                forKeyPath:@"rightBarButtonItem"
                   options:NSKeyValueObservingOptionInitial
                   context:nil];
    
    _navigationItemAttached = YES;
}

- (void)detachNavigationItem {
    if (!_navigationItemAttached) return;
    
    UINavigationItem *childItem = [_selectedViewController navigationItem];
    [childItem removeObserver:self forKeyPath:@"leftBarButtonItem"];
    [childItem removeObserver:self forKeyPath:@"rightBarButtonItem"];
    
    _navigationItemAttached = NO;
}

- (void)childNavigationItemDidChange {
    UINavigationItem *childItem = [_selectedViewController navigationItem];
    UINavigationItem *selfItem = [self navigationItem];
    
    [selfItem setLeftBarButtonItem:[childItem leftBarButtonItem]];
    [selfItem setRightBarButtonItem:[childItem rightBarButtonItem]];
}


#pragma mark - Properties

- (UIView *)childViewContainer {
    return _childViewContainer == nil ? [self view] : _childViewContainer;
}

- (void)setChildViewContainer:(UIView *)childViewContainer {
    _childViewContainer = childViewContainer;
}


- (UIViewController *)selectedViewController {
    return _selectedViewController;
}

- (void)setSelectedViewController:(UIViewController *)selectedViewController {
    NSUInteger index = [_viewControllers indexOfObject:selectedViewController];
    if (index == NSNotFound) {
        NSLog(@"setSelectedViewController called with view controller not in the tab bar.");
        return;
    }
    
    [self setActiveTab:index];
}

- (NSUInteger)selectedTabIndex {
    return _selectedTabIndex;
}

- (void)setSelectedTabIndex:(NSUInteger)selectedTabIndex {
    [self setActiveTab:selectedTabIndex];
}


#pragma mark - Misc handlers

// since we don't have access to the list of UIControls the user might have been using.
- (void)userDidTapTabButton:(id)sender {
    if (![sender isKindOfClass:[UIControl class]]) {
        NSLog(@"userDidTapTabButton called with sender that is not a UIControl.");
        return;
    }

    UIControl *tabControl = sender;
    [self setActiveTab:[tabControl tag] - self.tagOffset];
    
    // update selected button state
    [_selectedTabControl setSelected:NO];
    _selectedTabControl = tabControl;
    [_selectedTabControl setSelected:YES];
}


/// Main tab event handler sink
- (void)setActiveTab:(NSUInteger)tabIndex {
    if (tabIndex == _selectedTabIndex) {
        UIViewController *controller = [self selectedViewController];
        if (![controller respondsToSelector:@selector(popToRootViewControllerAnimated:)])
            return;

        [controller performSelector:@selector(popToRootViewControllerAnimated:)
                         withObject:[NSNumber numberWithBool:YES]];

        // pop to root view for navigation controllers on tapping the tab again.
        UINavigationController *nav = (id)_selectedViewController;
        [nav popToRootViewControllerAnimated:YES];
        return;
    }

    UIView *container = [self childViewContainer];

    // remove old view controller
    UIViewController *oldViewController = _selectedViewController;
    UIView *oldView = [oldViewController view];
    
    [_selectedViewController willMoveToParentViewController:nil];
    [self detachNavigationItem];
    [oldView removeFromSuperview];
    if (_contentViewConstraints) [container removeConstraints:_contentViewConstraints];
    [_selectedViewController removeFromParentViewController];

    // re-wire internal state and display new view controller    
    UIViewController *newViewController = [_viewControllers objectAtIndex:tabIndex];
    UIView *newView = [newViewController view];
    _selectedViewController = newViewController;
    _selectedTabIndex = tabIndex;

    [self addChildViewController:_selectedViewController];
    [newView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [container addSubview:newView];
    [self attachNavigationItem];

    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:4];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:newView
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:container
                                                        attribute:NSLayoutAttributeWidth
                                                       multiplier:1.0
                                                         constant:0.0]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:newView
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:container
                                                        attribute:NSLayoutAttributeHeight
                                                       multiplier:1.0
                                                         constant:0.0]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:newView
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:container
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0
                                                         constant:0.0]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:newView
                                                        attribute:NSLayoutAttributeCenterY
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:container
                                                        attribute:NSLayoutAttributeCenterY
                                                       multiplier:1.0
                                                         constant:0.0]];

    _contentViewConstraints = constraints;
    [container addConstraints:_contentViewConstraints];
    [_selectedViewController didMoveToParentViewController:self];
}


- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    BOOL interested = NO;
    interested = interested || [keyPath isEqualToString:@"leftBarButtonItem"];
    interested = interested || [keyPath isEqualToString:@"rightBarButtonItem"];
    
    if (!interested) return;
    [self childNavigationItemDidChange];
}


- (void)fixBackButton {
    if (![self navigationController]) return;
    
    // ensure back button title use tab view's title and not child tab's
    NSArray *controllers = [[self navigationController] viewControllers];
    if ([controllers count] < 2 || [controllers objectAtIndex:[controllers count] - 2] != self)
        return; // controller is being popped
    
    // new contorller was pushed onto the stack, fix back bar button title to use our title
    UIBarButtonItem *backBarButton = [UIBarButtonItem alloc];
    backBarButton = [backBarButton initWithTitle:[self title]
                                           style:UIBarButtonItemStyleBordered
                                          target:nil
                                          action:nil];
    
    [[self navigationItem] setBackBarButtonItem:backBarButton];
}

@end
