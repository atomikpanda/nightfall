#import <UIKit/UIKit.h>
#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>

@interface NightfallPrefsListController: PSListController {
}
@end

@implementation NightfallPrefsListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"NightfallPrefs" target:self] retain];
	}
	return _specifiers;
}
@end

// vim:ft=objc
