// Copyright © 2019 ColaBeanLab.
// All rights reserved.
/**********************************************************\
 * PROJECTNAME:  TTSocialModule
 * FILENAME:     TTSocialMessageObject.h
 * AUTHER:       ColaBean
 * CREATE TIME:  2019/5/14
 * MODIFY TIME:
 * DES:
 \**********************************************************/
//

#import <Foundation/Foundation.h>
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface TTSocialMessageObject : NSObject

/**
 text 文本内容 可拼接URL 格式：str + url，超出字节限制将截取str以...为后缀
 url最多拼接一个
 */
@property (nonatomic, copy) NSString *text;

/**
 分享的所媒体内容对象
 */
@property (nonatomic, strong, nullable) id sharedObject;

@end

@interface TTSharedObject : NSObject

@property (nonatomic, copy) NSString *title;

/**
 可拼接URL 格式：str + url, 超出字节限制将截取str以...为后缀
 url最多拼接一个
 */
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, strong) UIImage *thumbImage;

@end

@interface TTSharedImageObject : TTSharedObject

@property (nonatomic, strong) id shareImage;//qq 不支持网络图片
@property (nonatomic, copy) NSArray *shareImageArray;

@end

@interface TTSharedWebPageObject : TTSharedObject

@property (nonatomic, copy) NSString *webpageUrl;

/**
 对象唯一ID，用于唯一标识一个多媒体内容
 
 当第三方应用分享多媒体内容到微博时，应该将此参数设置为被分享的内容在自己的系统中的唯一标识
 @warning 不能为空，长度小于255
 */
@property (nonatomic, copy) NSString *wbObjectID;

@end

#pragma mark - UMMiniProgramObject

typedef NS_ENUM(NSUInteger, TTShareWXMiniProgramType){
    TTShareWXMiniProgramTypeRelease = 0,       //**< 正式版  */
    TTShareWXMiniProgramTypeTest = 1,        //**< 开发版  */
    TTShareWXMiniProgramTypePreview = 2,         //**< 体验版  */
};

@interface TTSharedMiniProgramObject : TTSharedObject

/**
 低版本微信网页链接
 */
@property (nonatomic, strong) NSString *webpageUrl;

/**
 小程序username
 */
@property (nonatomic, strong) NSString *userName;

/**
 小程序页面的路径
 */
@property (nonatomic, strong) NSString *path;

/**
 小程序新版本的预览图 128k
 */
@property (nonatomic, strong) NSData *hdImageData;

/**
 分享小程序的版本（正式，开发，体验）
 正式版 尾巴正常显示
 开发版 尾巴显示“未发布的小程序·开发版”
 体验版 尾巴显示“未发布的小程序·体验版”
 */
@property (nonatomic, assign) TTShareWXMiniProgramType miniProgramType;

/**
 是否使用带 shareTicket 的转发
 */
@property (nonatomic, assign) BOOL withShareTicket;

@end


NS_ASSUME_NONNULL_END
