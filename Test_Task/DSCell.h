//
//  DSCell.h
//  TestTask
//
//  Created by Dima on 11/1/14.
//  Copyright (c) 2014 Dima Soldatenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DSCell : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) BOOL isSelected;

- (UITableViewCell*) setColorsforCell:(UITableViewCell*) cell ;

@end
