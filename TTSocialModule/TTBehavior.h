// Copyright © 2019 ColaBeanLab.
// All rights reserved.
/**********************************************************\
 * PROJECTNAME:  TTSocialModule
 * FILENAME:     TTBehavior.h
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

@protocol TTBehavior <NSObject>
@end

@protocol TTShared <TTBehavior>

@property (nonatomic, copy) NSString *appKey;
@property (nonatomic, copy) NSString *redirectURL;
@property (nonatomic, assign) TTSocialPlatformType platform;
@property (nonatomic, copy) TTSocialSharedRequestCompletionHandler sharedCompletionHandler;

- (BOOL)sendMessageObject:(TTSocialMessageObject *)messageObject viewController:(UIViewController *_Nullable)vCtrl;

@end

//@protocol TTAuth <TTBehavior>
//
//@end

//@protocol TTPay <TTBehavior>
//
//@end

NS_ASSUME_NONNULL_END
