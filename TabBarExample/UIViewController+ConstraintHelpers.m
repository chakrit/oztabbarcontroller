#import "UIViewController+ConstraintHelpers.h"

@interface NSLayoutConstraint (_ConstraintHelpers)

+ (instancetype)constraintWithItem:(id)view1
                         attribute:(NSLayoutAttribute)attribute
                       equalToItem:(id)view2;

@end

@implementation NSLayoutConstraint (_ConstraintHelpers)

+ (instancetype)constraintWithItem:(id)view1
                         attribute:(NSLayoutAttribute)attribute
                       equalToItem:(id)view2 {
    return [NSLayoutConstraint constraintWithItem:view1
                                        attribute:attribute
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:view2
                                        attribute:attribute
                                       multiplier:1.0
                                         constant:0.0];
}

@end


@implementation UIViewController (ConstraintHelpers)

- (void)addConstraintToView:(UIView *)view toFillView:(UIView *)container {
    [container addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeWidth
                                                        equalToItem:container]];
    [container addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeHeight
                                                        equalToItem:container]];
    [container addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeCenterX
                                                        equalToItem:container]];
    [container addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeCenterY
                                                        equalToItem:container]];
}

- (void)addConstraintToView:(UIView *)view toCenterInContainer:(UIView *)container {
    [container addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeCenterX
                                                        equalToItem:container]];
    [container addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeCenterY
                                                        equalToItem:container]];
}

- (void)addConstraintToView:(UIView *)view toAlignBottomInContainer:(UIView *)container {
    [container addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeBottom
                                                        equalToItem:container]];
    [container addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeCenterX
                                                        equalToItem:container]];
}

- (void)addConstraintToView:(UIView *)view
      toAlignTopInContainer:(UIView *)container
                 topPadding:(CGFloat)padding {
    [container addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeCenterX
                                                        equalToItem:container]];
    [container addConstraint:[NSLayoutConstraint constraintWithItem:container
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:-padding]];
}

@end
