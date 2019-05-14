// Copyright © 2019 ColaBeanLab.
// All rights reserved.
/**********************************************************\
 * PROJECTNAME:  TTSocialModule
 * FILENAME:     TTSocialHandler.h
 * AUTHER:       ColaBean
 * CREATE TIME:  2019/5/14
 * MODIFY TIME:
 * DES:
 \**********************************************************/
//

#import <Foundation/Foundation.h>
#import "TTBehavior.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTSocialHandler : NSObject
{
    @protected
    NSString *appKey_, *redirectURL_;
}

+ (nullable TTSocialHandler *)handlerWithPlatform:(TTSocialPlatformType)platform;

- (BOOL)registerAppKey:(NSString *)appKey redirectURL:(NSString *_Nullable)redirectURL;
- (BOOL)handleOpenURL:(NSURL *)url options:(NSDictionary *)options delegate:(id<TTBehavior>_Nullable)delegate;
- (BOOL)isAppInstalled;

- (nullable id<TTShared>)sharedObject;
//- (id)authObject;

@end

NS_ASSUME_NONNULL_END
