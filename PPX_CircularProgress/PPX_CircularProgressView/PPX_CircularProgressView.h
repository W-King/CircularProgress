//
//  PPX_CircularProgressView.h
//  PPX_CircularProgress
//
//  Created by pipixia on 16/10/9.
//  Copyright © 2016年 pipixia. All rights reserved.
//

#import <UIKit/UIKit.h>

//宽
#define LINEWIDTH 5
//总时间
#define ALLTOTALTIME 30.0
//定时器时间
#define TIMER 0.1f


typedef NS_ENUM(NSInteger,CircularProgressViewType)
{
    CircularProgressViewType_Label = 0,
    CircularProgressViewType_Button,
};

@protocol CircularProgressDelegate;

@interface PPX_CircularProgressView : UIView

@property (assign, nonatomic) id <CircularProgressDelegate> delegate;

- (id)initWithFrame:(CGRect)frame
          backColor:(UIColor *)backColor
      progressColor:(UIColor *)progressColor
          lineWidth:(CGFloat)lineWidth
          totalTime:(CGFloat)totalTime
               type:(CircularProgressViewType)type;
- (void)play;
- (void)pause;
- (void)revert;

@end

@protocol CircularProgressDelegate <NSObject>

- (void)didUpdateProgressView:(CGFloat)progress;
- (void)stopEvent;

@end
