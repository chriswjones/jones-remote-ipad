//
// Created by Chris Jones on 12/27/14.
// Copyright (c) 2014 Axis. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FavoriteChannel : NSObject
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *channelNumber;

- (instancetype)initWithName:(NSString *)name channelNumber:(NSString *)channelNumber;

+ (instancetype)favoriteWithName:(NSString *)name channelNumber:(NSString *)channelNumber;

@end