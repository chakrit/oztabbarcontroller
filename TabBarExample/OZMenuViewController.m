#import "OZMenuViewController.h"
#import "OZChildViewController.h"
#import "OZLoadViewBasedViewController.h"
#import "OZNibBasedViewController.h"

@interface OZMenuViewController () <UITableViewDelegate, UITableViewDataSource>

@end


@implementation OZMenuViewController

- (NSString *)title { return @"Menu"; }

- (void)loadView {
    UITableView *tableView = tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [tableView setDelegate:self];
    [tableView setDataSource:self];

    [self setView:tableView];
}


- (void)userDidTapNibBasedExampleButton {
    OZNibBasedViewController *controller = nil;
    controller = [OZNibBasedViewController alloc];
    controller = [controller initWithViewControllers:[self childViewControllers]];
    
    [[self navigationController] pushViewController:controller animated:YES];
}

- (void)userDidTapLoadViewBasedExampleButton {
    OZLoadViewBasedViewController *controller = nil;
    controller = [OZLoadViewBasedViewController alloc];
    controller = [controller initWithViewControllers:[self childViewControllers]];
    
    [[self navigationController] pushViewController:controller animated:YES];
}

- (void)userDidTapVanillaExample {
    OZTabBarController *controller = nil;
    controller = [OZTabBarController alloc];
    controller = [controller initWithViewControllers:[self childViewControllers]];

    [controller setTitle:@"Vanilla"];
    [[self navigationController] pushViewController:controller animated:YES];

    // Rotate the views programmatically since we don't have any UI to do that w/ vanilla mode.
    __weak OZTabBarController *controller_ = controller;
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [controller_ setActiveTab:1];
    });

    time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [controller_ setActiveTab:2];
    });

    time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [controller_ setActiveTab:3];
    });
}


- (NSArray *)childViewControllers {
    return [NSArray arrayWithObjects:
            [self childViewControllerWithImageNamed:@"icon_github.png"],
            [self childViewControllerWithImageNamed:@"icon_globe.png"],
            [self childViewControllerWithImageNamed:@"icon_meter.png"],
            [self childViewControllerWithImageNamed:@"icon_power.png"], nil];
}

- (UIViewController *)childViewControllerWithImageNamed:(NSString *)imageName {
    UIViewController *controller = nil;
    controller = [OZChildViewController controllerWithImageNamed:imageName];
    controller = [[UINavigationController alloc] initWithRootViewController:controller];

    return controller;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch ([indexPath row]) {
        case 0: [self userDidTapNibBasedExampleButton]; break;
        case 1: [self userDidTapLoadViewBasedExampleButton]; break;
        case 2: [self userDidTapVanillaExample]; break;
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:@"cell"];
    switch ([indexPath row]) {
        case 0: [[cell textLabel] setText:@"Using NIB/XIBs"]; break;
        case 1: [[cell textLabel] setText:@"Overriding loadView()"]; break;
        case 2: [[cell textLabel] setText:@"Vanilla"]; break;
    }

    return cell;
}

@end

