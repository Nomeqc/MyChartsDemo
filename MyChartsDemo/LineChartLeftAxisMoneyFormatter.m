//
//  LineChartLeftAxisMoneyFormatter.m
//  MyChartsDemo
//
//  Created by iOSDeveloper003 on 17/2/20.
//  Copyright © 2017年 Liang. All rights reserved.
//

#import "LineChartLeftAxisMoneyFormatter.h"

@implementation LineChartLeftAxisMoneyFormatter

- (NSString * _Nonnull)stringForValue:(double)value axis:(ChartAxisBase * _Nullable)axis {
    if (value == 0.0) {
        //0.00不显示
        return @"";
    }
    return [NSString stringWithFormat:@"%.2lf",value];
}

@end
