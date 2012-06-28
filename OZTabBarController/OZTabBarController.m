//
//  OZTabBarController.m
//  OZTabBarController
//
//  Created by Chakrit Wichian on 6/20/12.
//  Copyright (c) 2012 Oozou Ltd. All rights reserved.
//

#import "OZTabBarController.h"


@implementation OZTabBarController {
    NSUInteger _selectedTabIndex;
    UIControl *_selectedTabControl;
    UIViewController *_selectedViewController;
    
    BOOL _shouldCallViewEvents;
    BOOL _navigationItemAttached;
}

@synthesize viewControllers = _viewControllers;
@synthesize childViewContainer = _childViewContainer;



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
        [self didInit];
    }
    return self;
}

- (void)didInit {
    _selectedViewController = nil;
    _selectedTabControl = nil;
    _selectedTabIndex = -1;

    _navigationItemAttached = NO;
        
    // iOS >= 5 automatically call view events on addSubview
    float osVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    _shouldCallViewEvents = osVersion < 5.0;
}

- (void)dealloc {
    [self detachNavigationItem];
    
    _selectedViewController = nil;
    _selectedTabControl = nil;
    
    _viewControllers = nil;
    _childViewContainer = nil;
}


#pragma mark - View events

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setActiveTab:0]; // also attachNavigationItem
}

- (void)viewWillUnload {
    [self detachNavigationItem];
    [super viewWillUnload];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_selectedViewController viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_selectedViewController viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self fixBackButton]; // use self.title instead of child view controller's
    [_selectedViewController viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [_selectedViewController viewDidDisappear:animated];
}


- (void)attachNavigationItem {
    if (_navigationItemAttached) return;
    
    [self childNavigationItemDidChange]; // update once
    
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

// TODO: There is no way to highlight the first control via setActiveTab:0
// since we don't have access to the list of UIControls the user might have been using.
- (void)userDidTapTabButton:(id)sender {
    if (![sender isKindOfClass:[UIControl class]]) {
        NSLog(@"userDidTapTabButton called with sender that is not a UIControl.");
        return;
    }
    
    UIControl *tabControl = sender;
    [self setActiveTab:[tabControl tag]];
    
    // update selected button state
    [_selectedTabControl setSelected:NO];
    _selectedTabControl = tabControl;
    [_selectedTabControl setSelected:YES];
}


/// Main tab event handler sink
- (void)setActiveTab:(NSUInteger)tabIndex {
    if (tabIndex == _selectedTabIndex) return;
    
    // remove old view controller
    UIViewController *oldViewController = _selectedViewController;
    UIView *oldView = [oldViewController view];
    
    if (_shouldCallViewEvents)
        [oldViewController viewWillDisappear:NO];
    
    [self detachNavigationItem];
    [oldView removeFromSuperview];
    
    if (_shouldCallViewEvents)
        [oldViewController viewDidDisappear:NO];
    
    // re-wire internal state and display new view controller    
    UIViewController *newViewController = [_viewControllers objectAtIndex:tabIndex];
    UIView *newView = [newViewController view];
    _selectedViewController = newViewController;
    _selectedTabIndex = tabIndex;

    if (_shouldCallViewEvents)
        [newViewController viewWillAppear:NO];
    
    [_childViewContainer addSubview:newView];
    [self attachNavigationItem];
    
    if (_shouldCallViewEvents)
        [newViewController viewDidAppear:NO];    
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
