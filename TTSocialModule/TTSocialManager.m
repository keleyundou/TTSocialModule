// Copyright © 2019 ColaBeanLab.
// All rights reserved.
/**********************************************************\
 * PROJECTNAME:  TTSocialModule
 * FILENAME:     TTSocialManager.m
 * AUTHER:       ColaBean
 * CREATE TIME:  2019/5/14
 * MODIFY TIME:
 * DES:
 \**********************************************************/
//

#import "TTSocialManager.h"

#import "TTWeChatHandler.h"
#import "TTWeiboHandler.h"

FOUNDATION_STATIC_INLINE TTSocialHandler *_Nullable TTHandlerForPlatform(TTSocialPlatformType platform, NSMutableDictionary *handlers) {
    TTSocialHandler *handler = [handlers objectForKey:@(platform)];
    if (handler == nil) {
        handler = [TTSocialHandler handlerWithPlatform:platform];
        if (handler) {
            [handlers setObject:handler forKey:@(platform)];
        }
    }
    return handler;
}

FOUNDATION_STATIC_INLINE NSString *_Nullable _ConvertToStringWithPlatformType(TTSocialPlatformType platform) {
    NSString *typeName = nil;
    switch (platform) {
        case TTSocialPlatformTypeWeChatSession:
        case TTSocialPlatformTypeWeChatTimeLine:
            typeName = @"WeChat";
            break;
        case TTSocialPlatformTypeWeibo:
            typeName = @"Weibo";
            break;
        case TTSocialPlatformTypeQZone:
            typeName = @"QZone";
            break;
        default:
            break;
    }
    return typeName;
}

@interface TTSocialManager ()
{
    id<TTBehavior> behaviorDelegate_;
}

@property (nonatomic, strong) NSMutableDictionary <NSNumber *, TTSocialHandler *>*cacheHandlerInstances;

@end

@implementation TTSocialManager

+ (instancetype)defaultManager {
    static dispatch_once_t onceToken;
    static TTSocialManager *_manager;
    dispatch_once(&onceToken, ^{
        _manager = [TTSocialManager new];
    });
    return _manager;
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _cacheHandlerInstances = [NSMutableDictionary dictionary];
    return self;
}

- (BOOL)setPlatform:(TTSocialPlatformType)platform appKey:(NSString *)appKey redirectURL:(NSString *)redirectURL {
    TTSocialHandler *handler = TTHandlerForPlatform(platform, _cacheHandlerInstances);
    BOOL ret = [handler registerAppKey:appKey redirectURL:redirectURL];
#if DEBUG
    NSString *platformName = _ConvertToStringWithPlatformType(platform);
    ret ? NSLog(@"🎉🎉🎉%@注册成功🎉🎉🎉", platformName) : NSLog(@"⚠️⚠️⚠️%@注册失败⚠️⚠️⚠️", platformName);
#endif
    return ret;
}

- (BOOL)sharedToPlatform:(TTSocialPlatformType)platform messageObject:(TTSocialMessageObject *)messageObject currentViewController:(UIViewController *)viewController completionHandler:(TTSocialSharedRequestCompletionHandler)completionHandler {
    TTSocialHandler *handler = TTHandlerForPlatform(platform, _cacheHandlerInstances);
    id<TTShared> shared = [handler sharedObject];
    shared.platform = platform;
    shared.sharedCompletionHandler = completionHandler;
    behaviorDelegate_ = nil;
    behaviorDelegate_ = shared;
    return [shared sendMessageObject:messageObject viewController:viewController];
}

- (BOOL)handleOpenURL:(NSURL *)url options:(NSDictionary *)options {
    for (TTSocialHandler *handler in _cacheHandlerInstances.allValues) {
        BOOL ret = [handler handleOpenURL:url options:options delegate:behaviorDelegate_];
        if (ret) return YES;
    }
    return NO;
}

- (BOOL)isInstalledForPlatform:(TTSocialPlatformType)platform {
    TTSocialHandler *handler = TTHandlerForPlatform(platform, _cacheHandlerInstances);
    return [handler isAppInstalled];
}

#pragma mark - handler


@end
