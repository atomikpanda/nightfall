%group Instagram

%hook IGDirectThreadViewController

- (void)viewWillLayoutSubviews
{
  %orig;
  UICollectionView *cv = MSHookIvar<UICollectionView *>(self, "_collectionView");
  cv.backgroundColor = kManager.darkColor;
}

%end

@interface IGDirectContentCell : UIView
@property (assign) BOOL nightfallIsCurrentUser;
@end

%hook IGDirectContentCell

%new
- (BOOL)nightfallIsCurrentUser
{
  return ((NSNumber *)objc_getAssociatedObject(self, @selector(nightfallIsCurrentUser))).boolValue;
}

%new
- (void)setNightfallIsCurrentUser:(BOOL)value
{
  objc_setAssociatedObject(self, @selector(nightfallIsCurrentUser), @(value), OBJC_ASSOCIATION_ASSIGN);
}

- (id)backgroundImageIsForCurrentUser:(BOOL)arg1
{
  BOOL origArg1 = arg1;
  arg1 = YES;
  self.nightfallIsCurrentUser = origArg1;
  return origArg1 ? colorImageWithColor((UIImage *)%orig, [UIColor accentBlue3Light]) : %orig;
}

- (BOOL)hidesBubbleBackground
{
  return NO;
}

- (void)prepareForReuse
{
  %orig;
}

%end

@interface IGDirectCommentCell : IGDirectContentCell
@end

%hook IGDirectCommentCell

- (UIColor *)defaultTextColor
{
  return %orig;//self.nightfallIsCurrentUser ? %orig : [UIColor blueColor];
}

%end

%end
