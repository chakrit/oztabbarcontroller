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

- (void)loadView {
    UIView *container = [[UIView alloc] init];
    UIImage *image = [UIImage imageNamed:_imageName];

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


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@ view did load", self);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%@ view did appear", self);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"%@ view will disappear", self);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"%@ view did disappear", self);
}


- (void)userDidTapImage:(id)sender {
    UIViewController *next = [[OZSecondChildViewController alloc] init];
    [[self navigationController] pushViewController:next animated:YES];
}


- (void)willMoveToParentViewController:(UIViewController *)parent {
    [super willMoveToParentViewController:parent];
    NSLog(@"%@ will move to parent: %@", self, parent);
}

- (void)didMoveToParentViewController:(UIViewController *)parent {
    [super didMoveToParentViewController:parent];
    NSLog(@"%@ did move to parent: %@", self, parent);
}

@end
