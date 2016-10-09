//
//  ViewController.m
//  PPX_CircularProgress
//
//  Created by pipixia on 16/10/9.
//  Copyright © 2016年 pipixia. All rights reserved.
//

#import "ViewController.h"
#import "PPX_CircularProgressView.h"



@interface ViewController ()<CircularProgressDelegate>

@property (strong, nonatomic) PPX_CircularProgressView *circularProgressView;

@property (nonatomic, strong) UILabel *timeLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    
    UIColor *backColor = [UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:236.0/255.0 alpha:1.0];
    UIColor *progressColor = [UIColor colorWithRed:82.0/255.0 green:135.0/255.0 blue:237.0/255.0 alpha:1.0];
    
    //alloc PPX_CircularProgressView instance
    self.circularProgressView = [[PPX_CircularProgressView alloc] initWithFrame:CGRectMake(41, 57, 100, 100)
                                                                  backColor:backColor
                                                              progressColor:progressColor
                                                                  lineWidth:LINEWIDTH
                                                                  totalTime:ALLTOTALTIME
                                                                           type:CircularProgressViewType_Label];
    self.circularProgressView.backgroundColor = [UIColor purpleColor];
    //set CircularProgressView delegate
    self.circularProgressView.delegate = self;
    
    //add CircularProgressView
    [self.view addSubview:self.circularProgressView];
    
    
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.textColor = [UIColor blackColor];
    self.timeLabel.frame = CGRectMake(0, 200, self.view.frame.size.width, 30);
    self.timeLabel.text = [NSString stringWithFormat:@"0.0/%.1f",ALLTOTALTIME];
    [self.view addSubview:self.timeLabel];
    
    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    playBtn.frame = CGRectMake(0, 300, 100, 50);
    playBtn.backgroundColor = [UIColor redColor];
    [playBtn setTitle:@"Play" forState:UIControlStateNormal];
    [playBtn addTarget:self action:@selector(playClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playBtn];
    
    UIButton *pauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pauseBtn.frame = CGRectMake(120, 300, 100, 50);
    pauseBtn.backgroundColor = [UIColor redColor];
    [pauseBtn setTitle:@"Pause" forState:UIControlStateNormal];
    [pauseBtn addTarget:self action:@selector(pauseClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pauseBtn];
    
    UIButton *revertBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    revertBtn.frame = CGRectMake(240, 300, 100, 50);
    revertBtn.backgroundColor = [UIColor redColor];
    [revertBtn setTitle:@"Revert" forState:UIControlStateNormal];
    [revertBtn addTarget:self action:@selector(revertClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:revertBtn];
    
}
- (void)playClicked
{
    [self.circularProgressView play];
}
- (void)pauseClicked
{
    [self.circularProgressView pause];
}
- (void)revertClicked
{
    [self.circularProgressView revert];
    self.timeLabel.text = [NSString stringWithFormat:@"0.0/%.1f",ALLTOTALTIME];
}
#pragma mark Circular Progress View Delegate method
- (void)didUpdateProgressView:(CGFloat)progress{
    //update timelabel
    self.timeLabel.text = [NSString stringWithFormat:@"%.1f/%.1f",progress,ALLTOTALTIME];

}
- (void)stopEvent
{
    NSLog(@"停止");
    [self.circularProgressView pause];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
