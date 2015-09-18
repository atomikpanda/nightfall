#import <substrate.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import <libcolorpicker.h>

@interface NFManager : NSObject
+ (NFManager *)sharedInstance;
- (BOOL)tweakEnabled;
- (UIColor *)darkColor;
- (BOOL)usesAccentColor;
- (UIColor *)accentColor;

- (BOOL)fwVersionIsEqualOrHigherThan:(NSString *)version;

- (UIColor *)lightTextColor;
- (UIColor *)midTextColor;

@property (nonatomic, retain) NSMutableDictionary *preferences;

@end

static NFManager *kManager;
static NSString *kBundleIdentifier;
