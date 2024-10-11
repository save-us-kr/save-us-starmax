#import "SaveUsStarmaxPlugin.h"
#if __has_include(<save_us_starmax/save_us_starmax-Swift.h>)
#import <save_us_starmax/save_us_starmax-Swift.h>
#else
// Import the generated header if it is not present.
#import "save_us_starmax-Swift.h"
#endif

@implementation SaveUsStarmaxPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    [SwiftSaveUsStarmaxPlugin registerWithRegistrar:registrar];
}
@end
