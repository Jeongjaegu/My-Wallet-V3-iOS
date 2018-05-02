//
//  CertificatePinner.h
//  Blockchain
//
//  Created by Kevin Wu on 8/24/16.
//  Copyright © 2016 Blockchain Luxembourg S.A. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol CertificatePinnerDelegate
- (void)failedToValidateCertificate:(NSString *)hostName;
@end

@interface CertificatePinner : NSObject
@property (nonatomic) id <CertificatePinnerDelegate> delegate;
- (void)pinCertificate;
- (void)didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler;
@end
