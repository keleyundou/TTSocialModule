// Copyright © 2019 ColaBeanLab.
// All rights reserved.
/**********************************************************\
 * PROJECTNAME:  TTSocialModule
 * FILENAME:     TTSocialHandler.m
 * AUTHER:       ColaBean
 * CREATE TIME:  2019/5/14
 * MODIFY TIME:
 * DES:
 \**********************************************************/
//

#import "TTSocialHandler.h"
#import "TTWeChatHandler.h"
#import "TTWeiboHandler.h"

@implementation TTSocialHandler

+ (TTSocialHandler *)handlerWithPlatform:(TTSocialPlatformType)platform {
    TTSocialHandler *handler = nil;
    switch (platform) {
        case TTSocialPlatformTypeWeChatSession:
        case TTSocialPlatformTypeWeChatTimeLine:
            handler = [TTWeChatHandler new];
            break;
        case TTSocialPlatformTypeWeibo:
            handler = [TTWeiboHandler new];
            break;
        default:
            break;
    }
    return handler;
}

- (BOOL)registerAppKey:(NSString *)appKey redirectURL:(NSString *_Nullable)redirectURL {
    if (appKey || redirectURL) {
        appKey_ = appKey;
        redirectURL_ = redirectURL;
        return NO;
    }
    
    [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a subclass: %@", NSStringFromSelector(_cmd), NSStringFromClass(self.class)];
    
    return NO;
}

- (BOOL)handleOpenURL:(NSURL *)url options:(NSDictionary *)options delegate:(id<TTBehavior>_Nullable)delegate {
    [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a subclass: %@", NSStringFromSelector(_cmd), NSStringFromClass(self.class)];
    return NO;
}

- (BOOL)isAppInstalled {
    [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a subclass: %@", NSStringFromSelector(_cmd), NSStringFromClass(self.class)];
    return NO;
}

- (id<TTShared>)sharedObject {
    return nil;
}

@end
