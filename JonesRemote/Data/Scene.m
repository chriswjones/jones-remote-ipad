//
// Created by Chris Jones on 12/27/14.
// Copyright (c) 2014 Axis. All rights reserved.
//

#import "Scene.h"


@implementation Scene {

}
- (instancetype)initWithName:(NSString *)name
                 leftTvInput:(enum InputDevice)leftTvInput
               leftTvChannel:(NSString *)leftTvChannel
               centerTvInput:(enum InputDevice)centerTvInput
             centerTvChannel:(NSString *)centerTvChannel
                rightTvInput:(enum InputDevice)rightTvInput
              rightTvChannel:(NSString *)rightTvChannel {
    self = [super init];
    if (self) {
        self.name = name;
        self.leftTvInput = leftTvInput;
        self.leftTvChannel = leftTvChannel;
        self.centerTvInput = centerTvInput;
        self.centerTvChannel = centerTvChannel;
        self.rightTvInput = rightTvInput;
        self.rightTvChannel = rightTvChannel;
    }

    return self;
}

- (instancetype)initWithName:(NSString *)name
                 leftTvInput:(enum InputDevice)leftTvInput
                    leftTvIr:(enum IRDevice)leftTvIr
               leftTvChannel:(NSString *)leftTvChannel
               centerTvInput:(enum InputDevice)centerTvInput
                  centerTvIr:(enum IRDevice)centerTvIr
             centerTvChannel:(NSString *)centerTvChannel
                rightTvInput:(enum InputDevice)rightTvInput
                   rightTvIr:(enum IRDevice)rightTvIr
              rightTvChannel:(NSString *)rightTvChannel {
    self = [super init];
    if (self) {
        self.name = name;
        self.leftTvInput = leftTvInput;
        self.leftTvIr = leftTvIr;
        self.leftTvChannel = leftTvChannel;
        self.centerTvInput = centerTvInput;
        self.centerTvIr = centerTvIr;
        self.centerTvChannel = centerTvChannel;
        self.rightTvInput = rightTvInput;
        self.rightTvIr = rightTvIr;
        self.rightTvChannel = rightTvChannel;
    }

    return self;
}

+ (instancetype)sceneWithName:(NSString *)name
                  leftTvInput:(enum InputDevice)leftTvInput
                     leftTvIr:(enum IRDevice)leftTvIr
                leftTvChannel:(NSString *)leftTvChannel
                centerTvInput:(enum InputDevice)centerTvInput
                   centerTvIr:(enum IRDevice)centerTvIr
              centerTvChannel:(NSString *)centerTvChannel
                 rightTvInput:(enum InputDevice)rightTvInput
                    rightTvIr:(enum IRDevice)rightTvIr
               rightTvChannel:(NSString *)rightTvChannel {
    return [[self alloc] initWithName:name leftTvInput:leftTvInput leftTvIr:leftTvIr leftTvChannel:leftTvChannel centerTvInput:centerTvInput centerTvIr:centerTvIr centerTvChannel:centerTvChannel rightTvInput:rightTvInput rightTvIr:rightTvIr rightTvChannel:rightTvChannel];
}


+ (instancetype)sceneWithName:(NSString *)name
                  leftTvInput:(enum InputDevice)leftTvInput
                leftTvChannel:(NSString *)leftTvChannel
                centerTvInput:(enum InputDevice)centerTvInput
              centerTvChannel:(NSString *)centerTvChannel
                 rightTvInput:(enum InputDevice)rightTvInput
               rightTvChannel:(NSString *)rightTvChannel {
    return [[self alloc] initWithName:name leftTvInput:leftTvInput leftTvChannel:leftTvChannel centerTvInput:centerTvInput centerTvChannel:centerTvChannel rightTvInput:rightTvInput rightTvChannel:rightTvChannel];
}

@end