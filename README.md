# CircularProgress
圆形进度条,自带倒计时,开始,停止,重置
```
1,引入头文件
PPX_CircularProgressView.h
2,代理
CircularProgressDelegate
3,初始化
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
4,实现代理方法
- (void)didUpdateProgressView:(CGFloat)progress
- (void)stopEvent
5,开始
 [self.circularProgressView play];
6,暂停
[self.circularProgressView pause];
7,重置
[self.circularProgressView revert];
 self.timeLabel.text = [NSString stringWithFormat:@"0.0/%.1f",ALLTOTALTIME];
```

