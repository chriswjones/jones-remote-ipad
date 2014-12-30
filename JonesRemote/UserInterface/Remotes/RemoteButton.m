//
// Created by Chris Jones on 12/27/14.
// Copyright (c) 2014 Axis. All rights reserved.
//

#import <UIColor+BFPaperColors/UIColor+BFPaperColors.h>
#import "RemoteButton.h"


@implementation RemoteButton {

}

+ (instancetype)buttonWithFrame:(CGRect)frame title:(NSString *)title {
    RemoteButton *btn = [[RemoteButton alloc] initWithFrame:frame raised:YES];
    btn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    btn.backgroundColor = [UIColor paperColorGray100];
    btn.tapCircleDiameter = bfPaperButton_tapCircleDiameterSmall / 2;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor paperColorGray900] forState:UIControlStateNormal];
    return btn;
}


@end