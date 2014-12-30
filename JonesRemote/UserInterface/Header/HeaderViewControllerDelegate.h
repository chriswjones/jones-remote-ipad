//
// Created by Chris Jones on 12/24/14.
// Copyright (c) 2014 Axis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MatrixEnum.h"

@protocol HeaderViewControllerDelegate <NSObject>

- (void)headerViewControllerSelected:(enum OutputDevice)outputDevice;

- (void)headerViewControllerSelected:(enum OutputDevice)outputDevice action:(BOOL)action;

@end