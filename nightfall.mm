#import "nightfall.h"

@implementation NFManager

- (NSMutableDictionary *)_preferences
{
  return nil;
}

+ (NFManager *)sharedInstance
{
  static NFManager *sharedInstance_;

  @synchronized(self)
  {
    if (!sharedInstance_)
    {
      sharedInstance_ = [[NFManager alloc] init];
    }

    return sharedInstance_;
  }
}

- (BOOL)fwVersionIsEqualOrHigherThan:(NSString *)version
{
    NSString *_version = @"";

    _version = [[UIDevice currentDevice] systemVersion];

    if ([_version compare:version options:NSNumericSearch] == NSOrderedDescending) return NO;
    else return YES;
}

- (BOOL)tweakEnabled
{
  return YES;
}

- (UIColor *)darkColor
{
  return [UIColor colorWithHue:0 saturation:0 brightness:0.125 alpha:1];
}

- (BOOL)usesAccentColor
{
  return NO;
}

- (UIColor *)accentColor
{
  return [UIColor colorWithHue:0.214 saturation:0.978 brightness:0.894 alpha:1];
}

- (UIColor *)lightTextColor
{
  return [UIColor whiteColor];
}

- (UIColor *)midTextColor
{
  return [UIColor lightGrayColor];
}

@end
