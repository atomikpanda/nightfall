%group Messages

%hook UIView

- (UIColor *)tintColor
{
  return kManager.usesAccentColor ? kManager.accentColor : %orig;
}

%end

%hook UINavigationBar

- (void)layoutSubviews
{
  %orig;
  self.barTintColor = kManager.darkColor;

  self.titleTextAttributes =
  @{
    NSForegroundColorAttributeName : kManager.lightTextColor
  };
}

%end

// Invert Status Bar @atomikpanda implementation

@interface UIStatusBarForegroundStyleAttributes : NSObject

- (UIColor *)tintColor;
- (double)height;
- (long long)idiom;
- (long long)legibilityStyle;

- (id)initWithHeight:(double)arg1 legibilityStyle:(long long)arg2 tintColor:(id)arg3 hasBusyBackground:(BOOL)arg4 idiom:(long long)arg5;

@end

%hook UIStatusBarForegroundView

- (UIStatusBarForegroundStyleAttributes *)foregroundStyle
{
  UIStatusBarForegroundStyleAttributes *fgsa = (UIStatusBarForegroundStyleAttributes *)%orig;

  UIColor *newTintColor = nil;

  if ([fgsa.tintColor brightness] == 0.f && [fgsa.tintColor saturation] == 0.f)
  {
    newTintColor = [UIColor whiteColor];
  }
  else if ([fgsa.tintColor brightness] == 1.f && [fgsa.tintColor saturation] == 0.f)
  {
    newTintColor = [UIColor blackColor];
  }

  if (newTintColor)
    fgsa = [[%c(UIStatusBarForegroundStyleAttributes) alloc] initWithHeight:[fgsa height] legibilityStyle:[fgsa legibilityStyle] tintColor:newTintColor hasBusyBackground:MSHookIvar<BOOL>(fgsa, "_hasBusyBackground") idiom:[fgsa idiom]];

  return fgsa;
}

%end

// end status bar


@interface CKConversationListCell : UITableViewCell
// UIDateLabel *_dateLabel;
// UILabel *_summaryLabel;
// UIImageView *_unreadIndicatorImageView;
// UIImageView *_chevronImageView;
// UILabel *_fromLabel;
@end

%hook CKConversationListCell

- (void)layoutSubviews
{
  %orig;
  self.backgroundColor = kManager.darkColor;

  MSHookIvar<UILabel *>(self, "_fromLabel").textColor =
  kManager.lightTextColor;

  MSHookIvar<UILabel *>(self, "_summaryLabel").textColor =
  kManager.midTextColor;

  MSHookIvar<UILabel *>(self, "_dateLabel").textColor =
  kManager.midTextColor;

}

%end

@interface CKTranscriptCollectionView : UIView
@end

%hook CKTranscriptCollectionView

- (void)layoutSubviews
{
  %orig;
  self.backgroundColor = kManager.darkColor;
}

%end

%hook CKTranscriptBalloonCell

- (id)init
{
	UIView *cell = (UIView *)%orig;

	[cell setBackgroundColor:[UIColor clearColor]];

	return cell;
}

- (void)layoutSubviews
{
	%orig;
	[self setBackgroundColor:[UIColor clearColor]];
}

%end

%hook CKColoredBalloonView

- (BOOL)wantsGradient
{
	return NO;
}

%end

%hook CKTextBalloonView

- (void)setCanUseOpaqueMask:(BOOL)canIt
{
	canIt = NO;
	%orig;
}

%end

%hook CKImageBalloonView

- (void)setCanUseOpaqueMask:(BOOL)canIt
{
	canIt = NO;
	%orig;
}

%end

%end
