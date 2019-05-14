// Copyright © 2019 ColaBeanLab.
// All rights reserved.
/**********************************************************\
 * PROJECTNAME:  TTSocialModule
 * FILENAME:     TTWeChatHandler.m
 * AUTHER:       ColaBean
 * CREATE TIME:  2019/5/14
 * MODIFY TIME:
 * DES:
 \**********************************************************/
//

#import "TTWeChatHandler.h"
#import "TTWeChatShared.h"

#import <WechatOpenSDK/WXApi.h>

@implementation TTWeChatHandler

- (id<TTShared>)sharedObject {
    id<TTShared> shared = [TTWeChatShared new];
    shared.appKey = appKey_;
    shared.redirectURL = redirectURL_;
    return shared;
}

#pragma mark - override
- (BOOL)registerAppKey:(NSString *)appKey redirectURL:(NSString *)redirectURL {
    [super registerAppKey:appKey redirectURL:redirectURL];
    return [WXApi registerApp:appKey];
}

- (BOOL)handleOpenURL:(NSURL *)url options:(NSDictionary *)options delegate:(id<TTBehavior>)delegate {
    if ([delegate conformsToProtocol:@protocol(WXApiDelegate)]) {
        id delegateObject = delegate;
        return [WXApi handleOpenURL:url delegate:delegateObject];
    }
    return NO;
}

- (BOOL)isAppInstalled {
    return [WXApi isWXAppInstalled];
}

@end
