//
//  DSCell.m
//  TestTask
//
//  Created by Dima on 11/1/14.
//  Copyright (c) 2014 Dima Soldatenko. All rights reserved.
//

#import "DSCell.h"

@implementation DSCell

- (UITableViewCell*) setColorsforCell:(UITableViewCell*)  cell {
    
    if (  self.isSelected) {
        cell.backgroundView.backgroundColor = self.color;
        cell.textLabel.textColor = [UIColor darkGrayColor];
    }
    else
    {
        cell.backgroundView.backgroundColor = [UIColor darkGrayColor];
        cell.textLabel.textColor = self.color;
    }
    
    return cell;
    
}

@end
