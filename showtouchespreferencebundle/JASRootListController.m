#import "JASRootListController.h"
#import <Foundation/Foundation.h>

@implementation JASRootListController

- (NSArray *)specifiers {
    if (!_specifiers) {
        _specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
    }

    return _specifiers;
}

@end
