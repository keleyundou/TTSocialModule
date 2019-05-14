// Copyright © 2019 ColaBeanLab.
// All rights reserved.
/**********************************************************\
 * PROJECTNAME:  TTSocialModule
 * FILENAME:     TTWeiboHandler.m
 * AUTHER:       ColaBean
 * CREATE TIME:  2019/5/14
 * MODIFY TIME:
 * DES:
 \**********************************************************/
//

#import "TTWeiboHandler.h"
#import "TTWeiboShared.h"

#import <Weibo_SDK/WeiboSDK.h>

@implementation TTWeiboHandler

- (id<TTShared>)sharedObject {
    id<TTShared> shared = [TTWeiboShared new];
    shared.appKey = appKey_;
    shared.redirectURL = redirectURL_;
    return shared;
}

#pragma mark - override
- (BOOL)registerAppKey:(NSString *)appKey redirectURL:(NSString *)redirectURL {
    [super registerAppKey:appKey redirectURL:redirectURL];
    return [WeiboSDK registerApp:appKey];
}

- (BOOL)handleOpenURL:(NSURL *)url options:(NSDictionary *)options delegate:(id<TTBehavior>)delegate {
    if ([delegate conformsToProtocol:@protocol(WeiboSDKDelegate)]) {
        id delegateObject = delegate;
        return [WeiboSDK handleOpenURL:url delegate:delegateObject];
    }
    return NO;
}

- (BOOL)isAppInstalled {
    return [WeiboSDK isWeiboAppInstalled];
}

@end
