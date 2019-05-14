// Copyright © 2019 ColaBeanLab.
// All rights reserved.
/**********************************************************\
 * PROJECTNAME:  TTSocialModule
 * FILENAME:     TTSocialResponse.m
 * AUTHER:       ColaBean
 * CREATE TIME:  2019/5/14
 * MODIFY TIME:
 * DES:
 \**********************************************************/
//

#import "TTSocialResponse.h"

@implementation TTSocialResponse

@end

@implementation TTSocialSharedResponse

+ (TTSocialSharedResponse *)sharedResponseWithMessage:(NSString *)message {
    TTSocialSharedResponse *resp = [TTSocialSharedResponse new];
    resp.message = message;
    return resp;
}

@end

@implementation TTSocialAuthResponse

@end

@implementation TTSocialUserInfoResponse

+ (instancetype)userInfoWithResp:(TTSocialResponse *)resp {
    TTSocialUserInfoResponse *userInfo = [TTSocialUserInfoResponse new];
    userInfo.uid = resp.uid;
    userInfo.openid = resp.openid;
    userInfo.unionid = resp.unionid;
    userInfo.accessToken = resp.accessToken;
    userInfo.refreshToken = resp.refreshToken;
    userInfo.expiration = resp.expiration;
    return userInfo;
}

@end
