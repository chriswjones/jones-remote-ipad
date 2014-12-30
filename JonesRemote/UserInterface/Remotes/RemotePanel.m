//
// Created by Chris Jones on 12/27/14.
// Copyright (c) 2014 Axis. All rights reserved.
//

#import <UIColor+BFPaperColors/UIColor+BFPaperColors.h>
#import "RemotePanel.h"


@implementation RemotePanel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 1.5f;
        self.backgroundColor = [UIColor paperColorGray100];

        CGRect downRect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height + 1.f);
        self.layer.shadowColor = [UIColor colorWithWhite:0.2f alpha:1.f].CGColor;
        self.layer.shadowOpacity = 0.7f;
        self.layer.shadowRadius = 1.5f;
        self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:downRect cornerRadius:self.layer.cornerRadius].CGPath;
        self.layer.shadowOffset = CGSizeMake(0.f, 1.0f);
    }

    return self;
}


@end