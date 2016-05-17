//
//  KLNetworking.h
//  AFNetworkingDemo
//
//  Created by bcmac3 on 16/5/17.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 项目打包上线都不会打印日志，因此可放心。
#ifdef DEBUG
#define KLAppLog(s, ... ) NSLog( @"[%@ in line %d] ===============>%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define KLAppLog(s, ... )
#endif

/**
 *  下载进度Block
 *
 *  @param bytesRead      已下载的大小
 *  @param totalBytesRead 文件总大小
 */
typedef void (^KLDownloadProgress)(int64_t bytesRead, int64_t totalBytesRead);
typedef KLDownloadProgress KLGetProgress;
typedef KLDownloadProgress KLPostProgress;

/**
 *  上传进度Block
 *
 *  @param bytesWritten      已上传的大小
 *  @param totalBytesWritten 总上传的大小
 */
typedef void (^KLUploadProgress)(int64_t bytesWritten, int64_t totalBytesWritten);

typedef NS_ENUM(NSUInteger, KLResponseType) {
    KLResponseTypeJSON = 1, // 默认-JSON
    KLResponseTypeXML  = 2, // XML
    KLResponseTypeData = 3  // Data-需自己转换
};

typedef NS_ENUM(NSUInteger, KLRequestType) {
    KLRequestTypeJSON      = 1, // 默认
    KLRequestTypePlainTest = 2  // text/html
};

typedef NS_ENUM(NSInteger, KLNetworkStatus) {
    KLNetworkStatusUnknown          = -1, // 未知网络
    KLNetworkStatusNotReachable     = 0,  // 网络无连接
    KLNetworkStatusReachableViaWWAN = 1,  // 2、3、4G
    KLNetworkStatusReachableViaWiFi = 2   // WIFI
};

typedef NSURLSessionTask KLURLSessionTask;
typedef void(^KLResponseSuccess)(id response);
typedef void(^KLResponseFail)(NSError *error);

/**
 *  基于AFNetworking 3.x的封装
 */
@interface KLNetworking : NSObject

/**
 *  指定网络接口的基础url,即前面不动的部分，建议在AppDelegate里面设置
 *  如需使用不同的基础url,可以调用该方法更新，改变基础url
 *
 *  @param baseUrl 网络接口的基础url
 */
+ (void)updateBaseUrl:(NSString *)baseUrl;
+ (NSString *)baseUrl;

/**
 *  设置请求超时时间，默认为60s，建议在AppDelegate里面设置
 *
 *  @param timeout 超时时间
 */
+ (void)setTimeout:(NSTimeInterval)timeout;

/**
 *	当检查到网络异常时，是否从从本地提取数据。建议在AppDelegate里面设置
 *  一旦设置为YES,当设置刷新缓存时，若网络异常也会从缓存中读取数据。
 *  同样，如果设置超时不回调，同样也会在网络异常时回调，除非本地没有数据！
 *
 *	@param shouldObtain	默认为NO。
 */
+ (void)obtainDataFromLocalWhenNetworkUnconnected:(BOOL)shouldObtain;

/**
 *  默认只缓存GET请求的数据，对于POST请求是不缓存的。如果要缓存POST获取的数据，需要手动调用设置，建议在AppDelegate里面设置
 *  对JSON类型数据有效，对于PLIST、XML不确定！
 *
 *  @param isCacheGet      默认为YES
 *  @param shouldCachePost 默认为NO
 */
+ (void)cacheGetRequest:(BOOL)isCacheGet shoulCachePost:(BOOL)shouldCachePost;

/**
 *  获取缓存大小/bytes
 *
 *  @return 缓存大小
 */
+ (unsigned long long)totalCacheSize;

/**
 *  清除缓存
 */
+ (void)clearCaches;

/**
 *  是否显示打印信息
 *
 *  @param isDebug 开发期建议打开，默认NO。
 */
+ (void)enableInterfaceDebug:(BOOL)isDebug;

/**
 *  配置请求格式，默认为JSON。如果要求传XML或者PLIST，请在全局配置一下
 *
 *  @param requestType                   请求格式，默认为JSON
 *  @param requestType                   响应格式，默认为JSON
 *  @param shouldAutoEncode              是否加密，默认NO
 *  @param shouldCallbackOnCancelRequest 当取消请求时，是否要回调，默认为YES
 */
+ (void)configRequestType:(KLRequestType)requestType
             responseType:(KLResponseType)requestType
      shouldAutoEncodeUrl:(BOOL)shouldAutoEncode
  callbackOnCancelRequest:(BOOL)shouldCallbackOnCancelRequest;

/**
 *  配置公共的请求头，只调用一次即可，通常放在应用启动的时候配置就可以了
 *
 *  @param httpHeaders 只需要将与服务器商定的固定参数设置即可
 */
+ (void)configCommonHttpHeaders:(NSDictionary *)httpHeaders;

/**
 *  取消所有的请求
 */
+ (void)cancelAllRequest;

/**
 *	取消某个请求。如果是要取消某个请求，最好是引用接口所返回来的KLURLSessionTask对象，
 *  然后调用对象的cancel方法。如果不想引用对象，这里额外提供了一种方法来实现取消某个请求
 *
 *  @param url URL，可以是绝对URL，也可以是path（也就是不包括baseurl）
 */
+ (void)cancelRequestWithURL:(NSString *)url;

/**
 *  GET完整请求接口，若不指定baseurl，可传完整的url
 *
 *  @param url          接口路径，如/path/getArticleList
 *  @param refreshCache 是否刷新缓存。由于请求成功也可能没有数据，对于业务失败，只能通过人为手动判断
 *  @param params       接口中所需要的拼接参数
 *  @param progress     Get下载进度
 *  @param success      接口成功请求到数据的回调
 *  @param fail         接口成功请求到数据的回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (KLURLSessionTask *)getWithUrl:(NSString *)url
                    refreshCache:(BOOL)refreshCache
                          params:(NSDictionary *)params
                        progress:(KLGetProgress)progress
                         success:(KLResponseSuccess)success
                            fail:(KLResponseFail)fail;
/**
 *  是否需要刷新缓存,有参数
 */
+ (KLURLSessionTask *)getWithUrl :(NSString *)url
                     refreshCache:(BOOL)refreshCache
                           params:(NSDictionary *)params
                          success:(KLResponseSuccess)success
                             fail:(KLResponseFail)fail;
/**
 *  是否需要刷新缓存
 */
+ (KLURLSessionTask *)getWithUrl:(NSString *)url
                    refreshCache:(BOOL)refreshCache
                         success:(KLResponseSuccess)success
                            fail:(KLResponseFail)fail;

+ (KLURLSessionTask *)getWithUrl:(NSString *)url
                         success:(KLResponseSuccess)success
                            fail:(KLResponseFail)fail;

/**
 *  POST完整请求接口，若不指定baseurl，可传完整的url.
 *
 *  @param url          接口路径，如/path/getArticleList
 *  @param refreshCache 是否刷新缓存。由于请求成功也可能没有数据，对于业务失败，只能通过人为手动判断, 默认NO
 *  @param params       接口中所需要的拼接参数
 *  @param progress     Post下载进度
 *  @param success      接口成功请求到数据的回调
 *  @param fail         接口成功请求到数据的回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (KLURLSessionTask *)postWithUrl :(NSString *)url
                      refreshCache:(BOOL)refreshCache
                            params:(NSDictionary *)params
                          progress:(KLPostProgress)progress
                           success:(KLResponseSuccess)success
                              fail:(KLResponseFail)fail;
/**
 *  是否需要刷新缓存
 */
+ (KLURLSessionTask *)postWithUrl:(NSString *)url
                     refreshCache:(BOOL)refreshCache
                           params:(NSDictionary *)params
                          success:(KLResponseSuccess)success
                             fail:(KLResponseFail)fail;

+ (KLURLSessionTask *)postWithUrl:(NSString *)url
                           params:(NSDictionary *)params
                          success:(KLResponseSuccess)success
                             fail:(KLResponseFail)fail;

/**
 *  图片上传接口，若不指定baseurl，可传完整的url
 *
 *  @param image      图片对象
 *  @param url        上传图片的接口路径，如/path/images/
 *  @param filename   给图片起一个名字，默认为当前日期时间,格式为"yyyyMMddHHmmss"，后缀为`jpg`
 *  @param name       与指定的图片相关联的名称，这是由后端写接口的人指定的，如imagefiles
 *  @param mimeType   默认为image/jpeg
 *  @param parameters 参数
 *  @param progress   上传进度
 *  @param success    上传成功回调
 *  @param fail       上传失败回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (KLURLSessionTask *)uploadWithImage :(UIImage *)image
                                   url:(NSString *)url
                              filename:(NSString *)filename
                                  name:(NSString *)name
                              mimeType:(NSString *)mimeType
                            parameters:(NSDictionary *)parameters
                              progress:(KLUploadProgress)progress
                               success:(KLResponseSuccess)success
                                  fail:(KLResponseFail)fail;

/**
 *  文件上传接口，若不指定baseurl，可传完整的url
 *
 *  @param url           上传路径
 *  @param uploadingFile 待上传文件的路径(本地路径)
 *  @param progress      上传进度
 *  @param success       上传成功回调
 *  @param fail          上传成功回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (KLURLSessionTask *)uploadFileWithUrl :(NSString *)url
                           uploadingFile:(NSString *)uploadingFile
                                progress:(KLUploadProgress)progress
                                 success:(KLResponseSuccess)success
                                    fail:(KLResponseFail)fail;

/**
 *  文件下载接口，若不指定baseurl，可传完整的url
 *
 *  @param url           下载Url路径
 *  @param saveToPath    保存路径
 *  @param progressBlock 下载进度
 *  @param success       下载成功后的回调
 *  @param failure       下载失败后的回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (KLURLSessionTask *)downloadWithUrl :(NSString *)url
                            saveToPath:(NSString *)saveToPath
                              progress:(KLDownloadProgress)progressBlock
                               success:(KLResponseSuccess)success
                               failure:(KLResponseFail)failure;


@end

