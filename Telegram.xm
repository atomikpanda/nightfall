static UIImage *colorImageWithColor(UIImage *image, UIColor *color)
{
  UIEdgeInsets caps = [image capInsets];
      UIImageRenderingMode renderingMode = [image renderingMode];
      UIEdgeInsets rectInsets = [image alignmentRectInsets];

      UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
      CGContextRef context = UIGraphicsGetCurrentContext();
      CGContextTranslateCTM(context, 0, image.size.height);
      CGContextScaleCTM(context, 1.0, -1.0);

      CGContextSetBlendMode(context, kCGBlendModeNormal);
      CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
      //CGContextDrawImage(context, rect, img.CGImage);

      // Create gradient
      NSArray *colors = [NSArray arrayWithObjects:(id)color.CGColor, (id)color.CGColor, nil];
      CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
      CGGradientRef gradient = CGGradientCreateWithColors(space, (__bridge CFArrayRef)colors, NULL);

      // Apply gradient
      CGContextClipToMask(context, rect, image.CGImage);
      CGContextDrawLinearGradient(context, gradient, CGPointMake(0,0), CGPointMake(0, image.size.height), 0);
      UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
      UIGraphicsEndImageContext();

      CGGradientRelease(gradient);
      CGColorSpaceRelease(space);

      gradientImage = [gradientImage imageWithAlignmentRectInsets:rectInsets];
      gradientImage = [gradientImage imageWithRenderingMode:renderingMode];
      gradientImage = [gradientImage resizableImageWithCapInsets:caps];

      return gradientImage;
}

%group Telegram

@interface TGDialogListCell : UIView
@end

%hook TGDialogListCell

- (void)layoutSubviews
{
  %orig;
  self.backgroundColor = kManager.darkColor;
}

%end

@interface TGDialogListTextView : UILabel
@end

%hook TGDialogListTextView

- (void)layoutSubviews
{
  %orig;

  self.backgroundColor = kManager.darkColor;
  self.textColor = kManager.lightTextColor;
}

- (void)drawRect:(CGRect)rect
{

    UIColor *textColor = kManager.lightTextColor;

    NSDictionary *contactAttrs = @{ UITextAttributeFont : [self titleFont], NSForegroundColorAttributeName : textColor };

    NSAttributedString *contactStr = [[NSAttributedString alloc] initWithString:MSHookIvar<NSString *>(self, "_title") ? MSHookIvar<NSString *>(self, "_title") : @"" attributes:contactAttrs];

    CGRect titleFrame = MSHookIvar<struct CGRect>(self, "_titleFrame");
    titleFrame.origin.x = 0;
    titleFrame.origin.y = 0;


    NSDictionary *textAttrs = @{ UITextAttributeFont : [self textFont], NSForegroundColorAttributeName : [textColor colorWithAlphaComponent:0.75] };

    NSAttributedString *textStr = [[NSAttributedString alloc] initWithString:[self text] ? [self text] : @"" attributes:textAttrs];

    CGRect textFrame = MSHookIvar<struct CGRect>(self, "_textFrame");
    textFrame.origin.x = 0;
    textFrame.origin.y = titleFrame.size.height;


    NSString *authorName = MSHookIvar<NSString *>(self, "_authorName");
    CGRect authFrame;
    if ([self isMultichat])
    {
    NSDictionary *authAttrs = @{ UITextAttributeFont : [self authorNameFont], NSForegroundColorAttributeName : textColor };
    NSAttributedString *authStr = [[NSAttributedString alloc] initWithString:authorName ? authorName : @"" attributes:authAttrs];

    authFrame = MSHookIvar<struct CGRect>(self, "_authorNameFrame");
    authFrame.origin.x = 0;
    authFrame.origin.y = titleFrame.size.height;
    [authStr drawInRect:authFrame];
    [authStr release];
    textFrame.origin.y = textFrame.origin.y*2;
    }

    [contactStr drawInRect:titleFrame];

    if([self showTyping])
    {
    NSAttributedString *typingStr = [[NSAttributedString alloc] initWithString:[self typingText] ? [self typingText] : @"" attributes:textAttrs];

    [typingStr drawInRect:textFrame];
    [typingStr release];
    }
    else [textStr drawInRect:textFrame];

    [contactStr release];
    [textStr release];

}

%end

@interface TGModernImageView : UIImageView
@end

%hook TGModernImageView

- (void)layoutSubviews
{
  %orig;
  // self.image = colorImageWithColor(self.image, [UIColor redColor]);
}

%end

%end
