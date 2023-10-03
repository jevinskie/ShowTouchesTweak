#import <Foundation/Foundation.h>
#import "JASRootListController.h"

@implementation JASRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

@end
