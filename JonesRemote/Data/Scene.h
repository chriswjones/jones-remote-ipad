//
// Created by Chris Jones on 12/27/14.
// Copyright (c) 2014 Axis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MatrixEnum.h"
#import "IREnum.h"


@interface Scene : NSObject

@property(nonatomic, strong) NSString *name;

@property(nonatomic) enum InputDevice leftTvInput;
@property(nonatomic) enum IRDevice leftTvIr;
@property(nonatomic, strong) NSString *leftTvChannel;

@property(nonatomic) enum InputDevice centerTvInput;
@property(nonatomic) enum IRDevice centerTvIr;
@property(nonatomic, strong) NSString *centerTvChannel;

@property(nonatomic) enum InputDevice rightTvInput;
@property(nonatomic) enum IRDevice rightTvIr;
@property(nonatomic, strong) NSString *rightTvChannel;

- (instancetype)initWithName:(NSString *)name
                 leftTvInput:(enum InputDevice)leftTvInput
                    leftTvIr:(enum IRDevice)leftTvIr
               leftTvChannel:(NSString *)leftTvChannel
               centerTvInput:(enum InputDevice)centerTvInput
                  centerTvIr:(enum IRDevice)centerTvIr
             centerTvChannel:(NSString *)centerTvChannel
                rightTvInput:(enum InputDevice)rightTvInput
                   rightTvIr:(enum IRDevice)rightTvIr
              rightTvChannel:(NSString *)rightTvChannel;

+ (instancetype)sceneWithName:(NSString *)name
                  leftTvInput:(enum InputDevice)leftTvInput
                     leftTvIr:(enum IRDevice)leftTvIr
                leftTvChannel:(NSString *)leftTvChannel
                centerTvInput:(enum InputDevice)centerTvInput
                   centerTvIr:(enum IRDevice)centerTvIr
              centerTvChannel:(NSString *)centerTvChannel
                 rightTvInput:(enum InputDevice)rightTvInput
                    rightTvIr:(enum IRDevice)rightTvIr
               rightTvChannel:(NSString *)rightTvChannel;


@end