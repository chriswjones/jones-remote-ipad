//
// Created by Chris Jones on 12/27/14.
// Copyright (c) 2014 Axis. All rights reserved.
//

#import "FavoriteChannel.h"


@implementation FavoriteChannel {

}
- (instancetype)initWithName:(NSString *)name channelNumber:(NSString *)channelNumber {
    self = [super init];
    if (self) {
        self.name = name;
        self.channelNumber = channelNumber;
    }

    return self;
}

+ (instancetype)favoriteWithName:(NSString *)name channelNumber:(NSString *)channelNumber {
    return [[self alloc] initWithName:name channelNumber:channelNumber];
}

@end