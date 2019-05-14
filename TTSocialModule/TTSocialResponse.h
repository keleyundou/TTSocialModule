// Copyright © 2019 ColaBeanLab.
// All rights reserved.
/**********************************************************\
 * PROJECTNAME:  TTSocialModule
 * FILENAME:     TTSocialResponse.h
 * AUTHER:       ColaBean
 * CREATE TIME:  2019/5/14
 * MODIFY TIME:
 * DES:
 \**********************************************************/
//

#import <Foundation/Foundation.h>
#import "TTSocialDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTSocialResponse : NSObject

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *openid;
@property (nonatomic, copy) NSString *unionid;
@property (nonatomic, copy) NSString *refreshToken;
@property (nonatomic, copy) NSDate   *expiration;
@property (nonatomic, copy) NSString *accessToken;

@property (nonatomic, assign) TTSocialPlatformType platformType;

@property (nonatomic, strong) id origResp;

@end

@interface TTSocialSharedResponse : TTSocialResponse

@property (nonatomic, copy) NSString *message;
+ (TTSocialSharedResponse *)sharedResponseWithMessage:(NSString *)message;

@end

@interface TTSocialAuthResponse : TTSocialResponse
@end

@interface TTSocialUserInfoResponse : TTSocialResponse
+ (instancetype)userInfoWithResp:(TTSocialResponse *)resp;
//用户昵称
@property (nonatomic, copy) NSString *name;
//用户头像
@property (nonatomic, copy) NSString *iconUrl;
//用户性别 m：男、f：女、n：未知
@property (nonatomic, copy) NSString *gender;
@end

NS_ASSUME_NONNULL_END
