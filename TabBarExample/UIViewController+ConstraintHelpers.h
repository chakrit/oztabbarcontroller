
@interface UIViewController (ConstraintHelpers)

- (void)addConstraintToView:(UIView *)view toFillView:(UIView *)container;
- (void)addConstraintToView:(UIView *)view toCenterInContainer:(UIView *)container;
- (void)addConstraintToView:(UIView *)view toAlignBottomInContainer:(UIView *)container;
- (void)addConstraintToView:(UIView *)view
      toAlignTopInContainer:(UIView *)container
                 topPadding:(CGFloat)padding;

@end
