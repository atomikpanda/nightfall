#import "nightfall.h"

@implementation NFManager
@synthesize preferences;

+ (NFManager *)sharedInstance
{
  static NFManager *sharedInstance_;

  @synchronized(self)
  {
    if (!sharedInstance_)
    {
      sharedInstance_ = [[NFManager alloc] init];

      NSMutableDictionary *pdict = [NSMutableDictionary dictionaryWithContentsOfFile:@"/User/Library/Preferences/com.baileyseymour.nightfall.plist"];
      sharedInstance_.preferences = pdict ? pdict : [NSMutableDictionary dictionary];
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
  return LCPParseColorString([preferences objectForKey:@"darkColor"], @"#1a1a1a");
}

- (BOOL)usesAccentColor
{
  return YES;
}

- (UIColor *)accentColor
{
  return LCPParseColorString([preferences objectForKey:@"accentColor"], @"#d14926");
}

- (UIColor *)lightTextColor
{
  return [UIColor whiteColor];
}

- (UIColor *)midTextColor
{
  return [UIColor lightGrayColor];
}

- (void)dealloc
{
  self.preferences = nil;

  [super dealloc];
}

@end
