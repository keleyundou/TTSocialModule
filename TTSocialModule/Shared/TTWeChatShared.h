// Copyright © 2019 ColaBeanLab.
// All rights reserved.
/**********************************************************\
 * PROJECTNAME:  TTSocialModule
 * FILENAME:     TTWeChatShared.h
 * AUTHER:       ColaBean
 * CREATE TIME:  2019/5/14
 * MODIFY TIME:
 * DES:
 \**********************************************************/
//

#import "TTShared.h"
#import "WXApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTWeChatShared : TTShared<WXApiDelegate>

- (BOOL)sendMessageObject:(TTSocialMessageObject *)messageObject viewController:(UIViewController * _Nullable)vCtrl;

@end

NS_ASSUME_NONNULL_END
