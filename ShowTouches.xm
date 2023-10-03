#import <CoreFoundation/CoreFoundation.h>
#import <Foundation/Foundation.h>
#import <Foundation/NSUserDefaults+Private.h>

extern "C" bool os_variant_has_internal_diagnostics(const char *subsystem);

static NSString *nsDomainString       = @"vin.je.showtouches";
static NSString *nsNotificationString = @"vin.je.showtouches/preferences.changed";
static BOOL enabled;

static void notificationCallback(CFNotificationCenterRef center, void *observer, CFStringRef name,
                                 const void *object, CFDictionaryRef userInfo) {
    NSNumber *enabledValue =
        (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"enabled"
                                                               inDomain:nsDomainString];
    enabled = (enabledValue) ? [enabledValue boolValue] : YES;
}

%ctor {
    // Set variables on start up
    notificationCallback(NULL, NULL, NULL, NULL, NULL);

    // Register for 'PostNotification' notifications
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL,
                                    notificationCallback, (CFStringRef)nsNotificationString, NULL,
                                    CFNotificationSuspensionBehaviorCoalesce);

    // Add any personal initializations
	NSLog(@"ShowTouches loaded in %@\n", NSProcessInfo.processInfo.processName);
}

%hookf(bool, os_variant_has_internal_diagnostics, const char *subsystem) {
	if (!strcmp(subsystem, "com.apple.UIKit")) {
		return true;
	}
	return %orig;
}
