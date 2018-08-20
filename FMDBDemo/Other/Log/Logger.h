#import <Foundation/Foundation.h>

@class Logger;

@interface Logger : NSObject {
    NSMutableArray *entries;
}

@property(nonatomic, retain) NSMutableArray *entries;

+ (id)sharedLogger;

- (void)addLogEntry:(NSString *)entry;

- (NSString *)getEntriesAsString;

@end
