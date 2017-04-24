//
//  NSDate+WLAdd.m
//  MyChartsDemo
//
//  Created by iOSDeveloper003 on 17/2/20.
//  Copyright © 2017年 Liang. All rights reserved.
//

#import "NSDate+WLAdd.h"

@implementation NSDate (WLAdd)

- (NSDate *)dateByAddingDays:(NSInteger)days {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 86400 * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

@end
