//
// Created by Chris Jones on 12/27/14.
// Copyright (c) 2014 Axis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IREnum.h"

@interface TimeWarnerRemoteViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

- (void)bindInput:(enum IRDevice)irDevice;

@end