// Copyright © 2019 ColaBeanLab.
// All rights reserved.
/**********************************************************\
 * PROJECTNAME:  TTSocialModule
 * FILENAME:     TTSocialDefine.h
 * AUTHER:       ColaBean
 * CREATE TIME:  2019/5/14
 * MODIFY TIME:
 * DES:
 \**********************************************************/
//

#ifndef TTSocialDefine_h
#define TTSocialDefine_h

@import Foundation;
@import UIKit;

typedef NS_ENUM(NSUInteger, TTSocialPlatformType) {
    TTSocialPlatformTypeWeChatSession,
    TTSocialPlatformTypeWeChatTimeLine,
    TTSocialPlatformTypeWeibo,
    TTSocialPlatformTypeQZone,
};

typedef NS_ENUM(NSUInteger, TTSHARE_TYPE) {
    TTSHARE_TYPE_UNKNOWN = -1,
    TTSHARE_TYPE_TEXT = 0,
    TTSHARE_TYPE_IMAGE,
    TTSHARE_TYPE_WEB_PAGE,
    TTSHARE_TYPE_MINI_PROGRAM,
};

typedef void(^TTSocialSharedRequestCompletionHandler)(id _Nullable data, NSError *_Nullable error);

#define TT_SOCIAL_SHARE_RESULT_STATUS_SEND_SUCCESS @"分享成功！"
#define TT_SOCIAL_SHARE_RESULT_STATUS_SEND_CANCEL @"您已取消发送分享！"
#define TT_SOCIAL_SHARE_RESULT_STATUS_SEND_FAILURE @"分享失败！"

#endif /* TTSocialDefine_h */
