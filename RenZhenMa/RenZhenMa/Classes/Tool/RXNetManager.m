//
//  RXNetManager.m
//  RenZhenMa
//
//  Created by 乔喜洋 on 2018/9/6.
//  Copyright © 2018年 李瑞星. All rights reserved.
//

#import "RXNetManager.h"
#import "XYConst.h"

@implementation RXNetManager

+ (AFHTTPSessionManager *)shareInstance
{
    static AFHTTPSessionManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [AFHTTPSessionManager manager];
        
#if Area_XuChang
        //        instance.securityPolicy.allowInvalidCertificates = YES;
        
#else
        //
#endif
        instance.responseSerializer = [AFHTTPResponseSerializer serializer];
        //        instance.securityPolicy.validatesDomainName = NO;
        //        NSString *certFilePath = [[NSBundle mainBundle] pathForResource:@"Server_PublicCert" ofType:@"cer"];
        //        NSData *certData = [NSData dataWithContentsOfFile:certFilePath];
        //        NSSet *certSet = [NSSet setWithObject:certData];
        //        AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:certSet];
        //        policy.allowInvalidCertificates = YES;
        //        policy.validatesDomainName = NO;
        //        instance.securityPolicy = policy;
        //        instance.requestSerializer = [AFHTTPRequestSerializer serializer];
        //        instance.responseSerializer = [AFHTTPResponseSerializer serializer];
        //        instance.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", nil];
        //        [instance.securityPolicy setAllowInvalidCertificates:YES];
        //        instance.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        //        [instance setSessionDidBecomeInvalidBlock:^(NSURLSession * _Nonnull session, NSError * _Nonnull error) {
        //            DLog(@"setSessionDidBecomeInvalidBlock");
        //        }];
        //
        //
        //        __weak AFHTTPSessionManager *weakSelf = instance;
        //
        //
        //        [instance setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession*session, NSURLAuthenticationChallenge *challenge, NSURLCredential *__autoreleasing*_credential) {
        //            NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        //            __autoreleasing NSURLCredential *credential =nil;
        //            if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        //                if([weakSelf.securityPolicy evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:challenge.protectionSpace.host]) {
        //                    credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        //                    if(credential) {
        //                        disposition =NSURLSessionAuthChallengeUseCredential;
        //                    } else {
        //                        disposition =NSURLSessionAuthChallengePerformDefaultHandling;
        //                    }
        //                } else {
        //                    disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
        //                }
        //            } else {
        //                // client authentication
        //                SecIdentityRef identity = NULL;
        //                SecTrustRef trust = NULL;
        //                NSString *p12 = [[NSBundle mainBundle] pathForResource:@"Client_KeyStore"ofType:@"p12"];
        //                NSFileManager *fileManager =[NSFileManager defaultManager];
        //
        //                if(![fileManager fileExistsAtPath:p12])
        //                {
        //                    DLog(@"client.p12:not exist");
        //                }
        //                else
        //                {
        //                    NSData *PKCS12Data = [NSData dataWithContentsOfFile:p12];
        //
        //                    if ([RXNetManager extractIdentity:&identity andTrust:&trust fromPKCS12Data:PKCS12Data])
        //                    {
        //                        SecCertificateRef certificate = NULL;
        //                        SecIdentityCopyCertificate(identity, &certificate);
        //                        const void*certs[] = {certificate};
        //                        CFArrayRef certArray =CFArrayCreate(kCFAllocatorDefault, certs,1,NULL);
        //                        credential =[NSURLCredential credentialWithIdentity:identity certificates:(__bridge  NSArray*)certArray persistence:NSURLCredentialPersistencePermanent];
        //                        disposition =NSURLSessionAuthChallengeUseCredential;
        //                    }
        //                }
        //            }
        //            *_credential = credential;
        //            return disposition;
        //        }];
    });
    return instance;
}
+(BOOL)extractIdentity:(SecIdentityRef*)outIdentity andTrust:(SecTrustRef *)outTrust fromPKCS12Data:(NSData *)inPKCS12Data {
    OSStatus securityError = errSecSuccess;
    //client certificate password
    NSDictionary*optionsDictionary = [NSDictionary dictionaryWithObject:@"tianjianclientstore"
                                                                 forKey:(__bridge id)kSecImportExportPassphrase];
    
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import((__bridge CFDataRef)inPKCS12Data,(__bridge CFDictionaryRef)optionsDictionary,&items);
    
    if(securityError == 0) {
        CFDictionaryRef myIdentityAndTrust =CFArrayGetValueAtIndex(items,0);
        const void*tempIdentity =NULL;
        tempIdentity= CFDictionaryGetValue (myIdentityAndTrust,kSecImportItemIdentity);
        *outIdentity = (SecIdentityRef)tempIdentity;
        const void*tempTrust =NULL;
        tempTrust = CFDictionaryGetValue(myIdentityAndTrust,kSecImportItemTrust);
        *outTrust = (SecTrustRef)tempTrust;
    } else {
        DLog(@"Failedwith error code %d",(int)securityError);
        return NO;
    }
    return YES;
}
@end
