//
//  LineChartXAxisDateFormatter.m
//  MyChartsDemo
//
//  Created by iOSDeveloper003 on 17/2/20.
//  Copyright © 2017年 Liang. All rights reserved.
//

#import "LineChartXAxisDateFormatter.h"
#import "NSDate+WLAdd.h"

@implementation LineChartXAxisDateFormatter {
    NSArray *_dateLabels;
}

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    _dateLabels = [self dateLabels];
    return self;
}

- (NSString * _Nonnull)stringForValue:(double)value axis:(ChartAxisBase * _Nullable)axis {
    
    NSLog(@"value: %@",@(value).stringValue);
    //[[NSDate new] dateByAddingDays:29];
    return _dateLabels[(NSInteger)value];
}

- (NSArray *)dateLabels {
    NSDate *today = [[NSDate alloc] init];
    NSMutableArray *dateLabels = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 30; i++) {
       NSString *dateString = [[self dateFormatter] stringFromDate:[today dateByAddingDays:i]];
        [dateLabels addObject:dateString];
    }
    return dateLabels;
}

- (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd"];
    });
    return formatter;
}



@end
