//
//  PPX_CircularProgressView.m
//  PPX_CircularProgress
//
//  Created by pipixia on 16/10/9.
//  Copyright © 2016年 pipixia. All rights reserved.
//

#import "PPX_CircularProgressView.h"


@interface PPX_CircularProgressView ()
{
    BOOL isStart;
}
@property (strong, nonatomic) UIColor *backColor;
@property (strong, nonatomic) UIColor *progressColor;
@property (assign, nonatomic) CGFloat lineWidth;
@property (assign, nonatomic) float progress;
@property (strong, nonatomic) NSTimer *timer;


@property (assign, nonatomic) CGFloat currentProgress;//目前的进展
@property (assign, nonatomic) CGFloat timerFloat;//总进展

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *stopButton;

@end


@implementation PPX_CircularProgressView

- (id)initWithFrame:(CGRect)frame
          backColor:(UIColor *)backColor
      progressColor:(UIColor *)progressColor
          lineWidth:(CGFloat)lineWidth
          totalTime:(CGFloat)totalTime
               type:(CircularProgressViewType)type;

{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        _backColor = backColor;
        _progressColor = progressColor;
        _lineWidth = lineWidth;
        _timerFloat = totalTime;
        _currentProgress = 0.0f;
        isStart = YES;
        
        if (type == CircularProgressViewType_Label)
        {
            _timeLabel = [[UILabel alloc]init];
            _timeLabel.font = [UIFont systemFontOfSize:20.0f];
            _timeLabel.textAlignment = NSTextAlignmentCenter;
            _timeLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
            _timeLabel.text = @"0";
            [self addSubview:_timeLabel];
        }
        else
        {
            _stopButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _stopButton.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
            [_stopButton setTitle:@"Stop" forState:UIControlStateNormal];
            [_stopButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [_stopButton addTarget:self action:@selector(stopClicked) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_stopButton];
        }
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //draw background circle
    UIBezierPath *backCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width / 2,self.bounds.size.height / 2)
                                                              radius:self.bounds.size.width / 2 - self.lineWidth / 2
                                                          startAngle:(CGFloat) - M_PI_2
                                                            endAngle:(CGFloat)(1.5 * M_PI)
                                                           clockwise:YES];
    [self.backColor setStroke];
    backCircle.lineWidth = self.lineWidth;
    [backCircle stroke];
    
    if (self.progress != 0)
    {
        //draw progress circle
        UIBezierPath *progressCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width / 2,self.bounds.size.height / 2)
                                                                      radius:self.bounds.size.width / 2 - self.lineWidth / 2
                                                                  startAngle:(CGFloat) - M_PI_2
                                                                    endAngle:(CGFloat)(- M_PI_2 + self.progress * 2 * M_PI)
                                                                   clockwise:YES];
        [self.progressColor setStroke];
        progressCircle.lineWidth = self.lineWidth;
        [progressCircle stroke];
    }
}

- (void)updateProgressCircle{
    
    self.currentProgress += 0.1f;
    //update progress value
    self.progress = (float) (_currentProgress / _timerFloat);
    //redraw back & progress circles
    [self setNeedsDisplay];
    
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(CircularProgressDelegate)])
    {
        [self.delegate didUpdateProgressView:self.currentProgress];
    }
    _timeLabel.text = [NSString stringWithFormat:@"%.0f",self.currentProgress];
    if (self.progress >= 1.0f)
    {
        //invalid timer
        [self.timer invalidate];
        self.currentProgress = 0.0f;
        //restore progress value
        //        self.progress = 0;
        //self redraw
        //        [self setNeedsDisplay];
    }
}
- (void)stopClicked
{
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(CircularProgressDelegate)])
    {
        [self.delegate stopEvent];
    }
    
}
- (void)play{
    if (isStart)
    {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:TIMER target:self selector:@selector(updateProgressCircle) userInfo:nil repeats:YES];
        [self.timer fire];
        isStart = NO;
    }
}

- (void)pause{
    if (!isStart)
    {
        [self.timer invalidate];
        isStart = YES;
    }
}

- (void)revert{
    isStart = YES;
    [self updateProgressCircle];
    self.progress = 0;
    self.currentProgress = 0.0f;
    _timeLabel.text = @"0";
    [self.timer invalidate];
}


@end
