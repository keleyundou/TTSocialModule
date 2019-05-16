// Copyright © 2019 ColaBeanLab.
// All rights reserved.
/**********************************************************\
 * PROJECTNAME:  TTSocialModule
 * FILENAME:     TTSocialManager.h
 * AUTHER:       ColaBean
 * CREATE TIME:  2019/5/14
 * MODIFY TIME:
 * DES:
 \**********************************************************/
//

#import <Foundation/Foundation.h>
#import "TTSocialDefine.h"

NS_ASSUME_NONNULL_BEGIN
@class TTSocialMessageObject;

@interface TTSocialManager : NSObject

@property (nonatomic, class, readonly) TTSocialManager *defaultManager;

- (BOOL)setPlatform:(TTSocialPlatformType)platform
             appKey:(NSString *)appKey
        redirectURL:(NSString *_Nullable)redirectURL;

- (BOOL)sharedToPlatform:(TTSocialPlatformType)platform
           messageObject:(TTSocialMessageObject *)messageObject
   currentViewController:(nullable UIViewController *)viewController
       completionHandler:(nullable TTSocialSharedRequestCompletionHandler)completionHandler;

//- (void)auth;
//- (void)pay;

- (BOOL)handleOpenURL:(NSURL *)url options:(NSDictionary *)options;

- (BOOL)isInstalledForPlatform:(TTSocialPlatformType)platform;

@end

NS_ASSUME_NONNULL_END
