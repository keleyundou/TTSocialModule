// Copyright © 2019 ColaBeanLab.
// All rights reserved.
/**********************************************************\
 * PROJECTNAME:  TTSocialModule
 * FILENAME:     TTShared.m
 * AUTHER:       ColaBean
 * CREATE TIME:  2019/5/14
 * MODIFY TIME:
 * DES:
 \**********************************************************/
//

#import "TTShared.h"

@implementation TTShared
@synthesize appKey = _appKey, redirectURL = _redirectURL;
@synthesize platform = _platform;
@synthesize sharedCompletionHandler = _sharedCompletionHandler;

- (BOOL)sendMessageObject:(TTSocialMessageObject *)messageObject viewController:(UIViewController *)vCtrl {
    [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a subclass: %@", NSStringFromSelector(_cmd), NSStringFromClass(self.class)];
    return NO;
}

@end
