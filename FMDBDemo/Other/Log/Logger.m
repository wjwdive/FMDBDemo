#import "Logger.h"

@implementation Logger

@synthesize entries;

+ (id)sharedLogger {
    static Logger *sharedLogger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedLogger = [[self alloc] init];
    });
    return sharedLogger;
}

- (id)init {
    if (self = [super init]) {
        entries = [NSMutableArray array];
    }
    return self;
}

- (void)addLogEntry:(NSString *)entry {
    @synchronized (self) {
        if (entries) {
            NSString *entryWithDate = [self formatEntry:entry];
            [entries addObject:entryWithDate];
            [self notifyListeners:entryWithDate];
        }
    }
}

- (NSString *)formatEntry:(NSString *)entry {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *entryWithDate = [NSString stringWithFormat:@"%lu:[%@] %@", (long) entries.count, [dateFormatter stringFromDate:[NSDate date]], entry];
    return entryWithDate;
}

- (void)notifyListeners:(NSString *)entryWithDate {
    NSDictionary *entryData = @{@"Entry" : entryWithDate};
    [[NSNotificationCenter defaultCenter]
            postNotificationName:@"Log entry added"
                          object:self
                        userInfo:entryData];
}

- (NSString *)getEntriesAsString {
    if (entries) {
        return [[entries valueForKey:@"description"] componentsJoinedByString:@"\n"];
    }
    else {
        return @"";
    }
}

@end
