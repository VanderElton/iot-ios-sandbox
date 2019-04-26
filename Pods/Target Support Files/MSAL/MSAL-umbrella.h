#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "MSAL.h"
#import "MSALAADAuthority.h"
#import "MSALAccount.h"
#import "MSALAccountId.h"
#import "MSALADFSAuthority.h"
#import "MSALAuthority.h"
#import "MSALB2CAuthority.h"
#import "MSALConstants.h"
#import "MSALError.h"
#import "MSALLogger.h"
#import "MSALPublicClientApplication.h"
#import "MSALPublicClientStatusNotifications.h"
#import "MSALRedirectUri.h"
#import "MSALResult.h"
#import "MSALTelemetry.h"

FOUNDATION_EXPORT double MSALVersionNumber;
FOUNDATION_EXPORT const unsigned char MSALVersionString[];

