// Copyright (c) Microsoft Corporation.
// All rights reserved.
//
// This code is licensed under the MIT License.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files(the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and / or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions :
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "MSIDAADRequestConfigurator.h"
#import "MSIDHttpRequest.h"
#import "MSIDAADRequestErrorHandler.h"
#import "MSIDHttpResponseSerializer.h"
#import "MSIDDeviceId.h"
#import "NSDictionary+MSIDExtensions.h"
#import "MSIDVersion.h"
#import "MSIDConstants.h"
#import "MSIDAuthorityFactory.h"
#import "MSIDAuthority.h"
#import "MSIDConstants.h"
#import "MSIDAADJsonResponsePreprocessor.h"
#import "MSIDWorkPlaceJoinConstants.h"

static NSTimeInterval const s_defaultTimeoutInterval = 300;

@interface MSIDAADRequestConfigurator()
@end

@implementation MSIDAADRequestConfigurator

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _timeoutInterval = s_defaultTimeoutInterval;
    }
    return self;
}

- (void)configure:(MSIDHttpRequest *)request
{
    NSParameterAssert(request.urlRequest);
    NSParameterAssert(request.urlRequest.URL);
    
    __auto_type serializer = [MSIDHttpResponseSerializer new];
    serializer.preprocessor = [MSIDAADJsonResponsePreprocessor new];
    request.responseSerializer = serializer;
    request.errorHandler = [MSIDAADRequestErrorHandler new];
    
    __auto_type requestUrl = request.urlRequest.URL;
    
    __auto_type authority = [MSIDAuthorityFactory authorityFromUrl:request.urlRequest.URL context:request.context error:nil];
    // If url is authority, then we are trying to get network url of it. Otherwise we use provided url.
    __auto_type authorityUrl = [authority networkUrlWithContext:request.context];
    
    if (authorityUrl)
    {
        requestUrl = [requestUrl msidURLForPreferredHost:[authorityUrl msidHostWithPortIfNecessary] context:nil error:nil];
    }
    
    NSMutableURLRequest *mutableUrlRequest = [request.urlRequest mutableCopy];
    mutableUrlRequest.URL = requestUrl;
    mutableUrlRequest.timeoutInterval = self.timeoutInterval;
    mutableUrlRequest.cachePolicy = NSURLRequestReloadIgnoringCacheData;
#if TARGET_OS_IPHONE
    [mutableUrlRequest setValue:kMSIDPKeyAuthHeaderVersion forHTTPHeaderField:kMSIDPKeyAuthHeader];
#endif
    [mutableUrlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSMutableDictionary *headers = [mutableUrlRequest.allHTTPHeaderFields mutableCopy];
    [headers addEntriesFromDictionary:[MSIDDeviceId deviceId]];

    if ([request.context.appRequestMetadata count])
    {
        [headers addEntriesFromDictionary:request.context.appRequestMetadata];
    }
    
    if (request.context.correlationId)
    {
        headers[MSID_OAUTH2_CORRELATION_ID_REQUEST] = @"true";
        headers[MSID_OAUTH2_CORRELATION_ID_REQUEST_VALUE] = [request.context.correlationId UUIDString];
    }
    
    mutableUrlRequest.allHTTPHeaderFields = headers;
    request.urlRequest = mutableUrlRequest;
}

@end
