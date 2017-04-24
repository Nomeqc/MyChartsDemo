//
//  ViewController.m
//  MyChartsDemo
//
//  Created by iOSDeveloper003 on 17/2/18.
//  Copyright © 2017年 Liang. All rights reserved.
//

#import "ViewController.h"

@import Charts;
#import "LineChartXAxisDateFormatter.h"
#import "LineChartLeftAxisMoneyFormatter.h"
@interface ViewController ()
<ChartViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) LineChartView *lineChartView;

@property (strong, nonatomic) BarChartView *barChartView;

@property (strong, nonatomic) PieChartView *pieChartView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    [self.view addSubview:self.scrollView];
    self.scrollView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self setupLineView];
    [self setupBarView];
    [self setupPieChartView];
    [self.scrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, CGRectGetMaxY(self.pieChartView.frame) + 30)];
    
}

- (void)setupPieChartView {
    [self.scrollView addSubview:self.pieChartView];
    self.pieChartView.frame = CGRectMake(15, CGRectGetMaxY(self.barChartView.frame) + 20, [UIScreen mainScreen].bounds.size.width - 30, 210);
    
    self.pieChartView.delegate = self;
    self.pieChartView.legend.enabled = NO;
    self.pieChartView.chartDescription.enabled = NO;
    self.pieChartView.rotationEnabled = NO;
    self.pieChartView.highlightPerTapEnabled = NO;
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 2; i++) {
        double val = arc4random_uniform(2000) + 15;
        [values addObject:[[PieChartDataEntry alloc] initWithValue:val]];
    }
    PieChartDataSet *set = [[PieChartDataSet alloc] initWithValues:values];
    
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
    [colors addObjectsFromArray:ChartColorTemplates.joyful];
    set.colors = colors;
    
    PieChartData *data = [[PieChartData alloc] initWithDataSet:set];
    self.pieChartView.data = data;
    [self.pieChartView animateWithYAxisDuration:1];
}

- (void)setupBarView {
    [self.scrollView addSubview:self.barChartView];
    self.barChartView.frame = CGRectMake(15, CGRectGetMaxY(self.lineChartView.frame) + 20, [UIScreen mainScreen].bounds.size.width - 30, 210);
    self.barChartView.delegate = self;
    self.barChartView.dragEnabled = YES;
    [self.barChartView setScaleEnabled:NO];
    self.barChartView.legend.enabled = NO;
    self.barChartView.chartDescription.enabled = NO;
    self.barChartView.rightAxis.enabled = NO;
    self.barChartView.xAxis.labelPosition = ChartLimitLabelPositionLeftBottom;
    //左右两边各留出柱子的一半宽度 以便完全显示
    self.barChartView.fitBars = YES;
    
    ChartYAxis *leftAxis = self.barChartView.leftAxis;
    //网格线颜色
    leftAxis.gridColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
    leftAxis.axisMinimum = 0.0;
    
    ChartXAxis *xAxis = self.barChartView.xAxis;
    //x轴是否绘制网格线
    xAxis.drawGridLinesEnabled = NO;
    //x轴标签位置
    xAxis.labelPosition = XAxisLabelPositionBottom;
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    double maxVal = 0;
    for (NSInteger i = 0; i < 6; i ++) {
        double val = arc4random_uniform(2000) + 1.0;
        maxVal = MAX(val, maxVal);
        [yVals addObject:[[BarChartDataEntry alloc] initWithX:(double)i y:val]];
    }
    leftAxis.axisMaximum = maxVal;
    
    
    BarChartDataSet *set = [[BarChartDataSet alloc] initWithValues:yVals label:@"set"];
    [set setColor:[self normalColor]];
    [set setHighlightColor:[[UIColor whiteColor] colorWithAlphaComponent:1]];
    [set setDrawValuesEnabled:NO];
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set];
    BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
    //柱子的宽度 1为完全占有没有空隙 0.8表示 空隙占0.2,柱子本身占0.8
    data.barWidth = 0.8;
    self.barChartView.data = data;
    
    [self.barChartView animateWithYAxisDuration:1.0];
}

- (void)setupLineView {
    [self.scrollView addSubview:self.lineChartView];
    self.lineChartView.frame = CGRectMake(15, 64, [UIScreen mainScreen].bounds.size.width - 30, 210);
    
    self.lineChartView.delegate = self;
    //是否可以拖拽
    self.lineChartView.dragEnabled = YES;
    //是否可以缩放
    [self.lineChartView setScaleEnabled:NO];
    //是否显示图标说明(实星矩形 + 文字)
    self.lineChartView.legend.enabled = NO;
    //是否显示描述标签
    self.lineChartView.chartDescription.enabled = NO;
    //是否显示右边坐标系
    self.lineChartView.rightAxis.enabled = NO;
    //x轴位置
    self.lineChartView.xAxis.labelPosition = ChartLimitLabelPositionLeftBottom;
    
    
    self.lineChartView.leftAxis.gridColor  = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
    self.lineChartView.leftAxis.valueFormatter = [[LineChartLeftAxisMoneyFormatter alloc] init];
    //self.lineChartView.leftAxis.drawZeroLineEnabled = NO;
    self.lineChartView.leftAxis.axisMinimum = 0;

    
    NSMutableArray *testValues = [@[@(0.01),@(0.00),@(0.14),@(0.10),@(0.00),
                                    @(0.00),@(0.00),@(0.00),@(0.00),@(0.00),
                                    @(0.00),@(0.00),@(0.00),@(0.00),@(0.00),
                                    @(0.00),@(0.00),@(0.00),@(0.00),@(0.01),
                                    @(0.01),@(1.03),@(0.02),@(0.01),@(0.01),
                                    @(0.00),@(0.00),@(0.00),@(0.00),@(0.00)] mutableCopy];
    NSMutableArray *values = [[NSMutableArray alloc] init];
    double maxVal = 0;
    for (NSInteger i = 0;  i < testValues.count; i++ ) {
        //        double val = arc4random_uniform(20) + 3;
        double val = [testValues[i] doubleValue];
        maxVal = MAX(val, maxVal);
        [values addObject:[[ChartDataEntry alloc] initWithX:i y:val]];
    }
    //设置 y轴 最大值
    self.lineChartView.leftAxis.axisMaximum = maxVal;
    
    self.lineChartView.xAxis.valueFormatter = [[LineChartXAxisDateFormatter alloc] init];
    self.lineChartView.xAxis.gridLineWidth = 0;
    
    LineChartDataSet *set = [[LineChartDataSet alloc] initWithValues:values label:@"DataSet"];
    
    set.mode = LineChartModeHorizontalBezier;
    //    set.lineDashLengths = @[@5.f, @2.5f];
    //    set.highlightLineDashLengths = @[@5.f, @2.5f];
    set.highlightLineWidth = 1;
    [set setColor:[self normalColor]];
    [set setCircleColor:UIColor.blackColor];
    set.lineWidth = 1.0;
    
    set.circleRadius = 0;
    set.drawCircleHoleEnabled = NO;
    set.valueFont = [UIFont systemFontOfSize:9.f];
    //是否绘制值
    set.drawValuesEnabled = NO;
    //set.formLineWidth = 1.0;
    //set.formSize = 15.0;
    set.fillAlpha = 0.2;
    set.fill = [ChartFill fillWithColor:[UIColor blueColor]];
    set.drawFilledEnabled = YES;
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set];
    
    LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
    self.lineChartView.data = data;
    [self.lineChartView animateWithYAxisDuration:1];
}
#pragma mark - ChartViewDelegate
- (void)chartValueSelected:(ChartViewBase * _Nonnull)chartView entry:(ChartDataEntry * _Nonnull)entry highlight:(ChartHighlight * _Nonnull)highlight {
    NSLog(@"x:%lf",entry.x);
    NSLog(@"highlight:x=%lf,y=%lf",highlight.x,highlight.y);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIColor *)normalColor {
    return [UIColor colorWithRed:0.25 green:0.51 blue:0.89 alpha:1];
}

- (UIColor *)hilightColor {
    return [[self normalColor] colorWithAlphaComponent:0.3];
}

- (LineChartView *)lineChartView {
	if(_lineChartView == nil) {
		_lineChartView = [[LineChartView alloc] init];
	}
	return _lineChartView;
}

- (BarChartView *)barChartView {
	if(_barChartView == nil) {
		_barChartView = [[BarChartView alloc] init];
	}
	return _barChartView;
}

- (PieChartView *)pieChartView {
	if(_pieChartView == nil) {
		_pieChartView = [[PieChartView alloc] init];
	}
	return _pieChartView;
}

- (UIScrollView *)scrollView {
	if(_scrollView == nil) {
		_scrollView = [[UIScrollView alloc] init];
	}
	return _scrollView;
}

@end
