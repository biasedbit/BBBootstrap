Pod::Spec.new do |s|
  s.name     = "BBBootstrap"
  s.version  = "1.0.0"
  s.summary  = "A comprehensive bundle of time-savers, for iOS and OSX development."
  s.homepage = "https://github.com/brunodecarvalho/BBBootstrap"
  s.license  = { :type => "Apache License, Version 2.0", :file => "LICENSE" }
  s.author   = { "Bruno de Carvalho" => "bruno@biasedbit.com" }
  s.source   = { :git => "https://github.com/brunodecarvalho/BBBootstrap.git", :tag => "1.0.0" }

  s.requires_arc = true

  s.ios.deployment_target = "5.0"
  s.ios.source_files = "Classes/**/*.{h,m}"
  s.ios.frameworks = "UIKit"

  s.osx.deployment_target = "10.7"
  s.osx.source_files = FileList["Classes/**/*.{h,m}"].exclude("Classes/UIKitExtensions")
  s.osx.frameworks = "AppKit"

  s.prefix_header_contents = <<-PREFIXHEADER
#import <Availability.h>

#if __IPHONE_OS_VERSION_MIN_REQUIRED
    #import <UIKit/UIKit.h>
#else
    #import <AppKit/AppKit.h>
#endif


// Global utility functions

#import "BBGlobals.h"


// Foundation extensions

#import "NSData+BBExtensions.h"
#import "NSDate+BBExtensions.h"
#import "NSDictionary+BBExtensions.h"
#import "NSFileManager+BBExtensions.h"
#import "NSMutableDictionary+BBExtensions.h"
#import "NSNotificationCenter+BBExtensions.h"
#import "NSObject+BBExtensions.h"
#import "NSString+BBExtensions.h"
#import "NSUbiquitousKeyValueStore+BBExtensions.h"
#import "NSUserDefaults+BBExtensions.h"


// UIKit extensions

#if __IPHONE_OS_VERSION_MIN_REQUIRED
    #import "UIActionSheet+BBExtensions.h"
    #import "UIAlertView+BBExtensions.h"
    #import "UIColor+BBExtensions.h"
    #import "UIDevice+BBExtensions.h"
    #import "UIImage+BBExtensions.h"
    #import "UIImageView+BBExtensions.h"
    #import "UITableView+BBExtensions.h"
    #import "UITextField+BBExtensions.h"
    #import "UIView+BBExtensions.h"
    #import "UITextField+BBExtensions.h"
    #import "UIViewController+BBExtensions.h"
#endif


// Utility classes

#import "BBProfiler.h"
#import "BBCancellable.h"
#import "BBCountdownLatch.h"


// Useful helpers

#if __IPHONE_OS_VERSION_MIN_REQUIRED
    #define RGB(r,g,b)      [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]
    #define RGBA(r,g,b,a)   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#endif

#define L10n(key)       NSLocalizedString(key, nil)

// Use this one on a 'default' branch of a switch/case construct
#define INVALID_SWITCH(fmt, ...) NSAssert(NO, @"Invalid switch: '%@' at %s", \
                                          [NSString stringWithFormat:fmt, ##__VA_ARGS__], __PRETTY_FUNCTION__)


// Logging

// Comment LOG_DEBUG out to avoid trace statements
#define LOG_DEBUG

#ifdef LOG_DEBUG
    #define LogDebug(fmt, ...)  NSLog((@"(DEBUG) " fmt), ##__VA_ARGS__);
#else
    #define LogDebug(...)
#endif

#define LogInfo(fmt, ...)   NSLog((@"(INFO) " fmt), ##__VA_ARGS__);
#define LogError(fmt, ...)  NSLog((@"(ERROR) " fmt), ##__VA_ARGS__);


// Debug helpers

#if DEBUG
    #define DLOG(...)   NSLog(__VA_ARGS__)
    #define DOBJ(o)     NSLog(@"%s=%@", #o, o)
    #define DMARK       NSLog(@"%s", __PRETTY_FUNCTION__)
    #define DRECT(r)    NSLog(@"%s=%@", #r, NSStringFromCGRect(r))
    #define DPOINT(p)   NSLog(@"%s=%@", #p, NSStringFromCGPoint(p))
    #define DSIZE(s)    NSLog(@"%s=%@", #s, NSStringFromCGSize(s))
    #define DBOOL(b)    NSLog(@"%s=%@", #b, (b?@"YES":@"NO"))
    #define DDOUBLE(d)  NSLog(@"%s=%Lf", #d, d)
    #define DFLOAT(f)   NSLog(@"%s=%f", #f, f)
    #define DINT(i)     NSLog(@"%s=%i", #i, i)
    #define DSTR(s)     NSLog(@"%s=%@", #s, s)
#else
    #define DLOG(...)
    #define DOBJ(o)
    #define DMARK
    #define DRECT(rect)
    #define DPOINT(point)
    #define DSIZE(size)
    #define DBOOL(b)
    #define DDOUBLE(d)
    #define DFLOAT(f)
    #define DINT(i)
    #define DSTR(s)
#endif

PREFIXHEADER
end
