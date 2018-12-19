//
//  LWMessage.m
//  LWMessage
//
//  Created by 程恒盛 on 17/1/16.
//  Copyright © 2017年 力王. All rights reserved.

#import "LWMessage.h"
#import "NSError+Message.h"
/**
 *  状态变更,处理逻辑如下:
 执行handler对象的preHandle方法,如果返回NO,状态变更处理结束.这种情况一般用在preHandle中,状态又进行了变更,此时后续的处理已经不需要了.
 执行handler对象的handle方法.如果在执行过程中,又变更了消息状态(如调用self.failed=YES),此时该新状态是存储在nextState中的,并不会立刻改变当前的state.因此后续的逻辑还是可以继续执行.但是不建议这样做,这样做会使后面逻辑依据的消息状态已不对.
 执行handler对象的postHandle方法.
 对self.state,调用对应的whenXXX(self);block方法.
 遍历self.responders,调用其对应的preExecuteMessage,ExecuteMessage,postExecuteMessage等方法.如果preExecuteMessage返回了NO,则该responder的ExecuteMessage与postExecuteMessage方法不会执行,但是不会影响其他的responder
 *
 *   state 新的状态
 */
@interface LWMessage ()


@end
@implementation LWMessage
- (NSString *)description{
    NSString *desc = [super description];
    return [NSString stringWithFormat:@"%@,name:%@,state:%@,progress:%@%@",desc,self.name,[self stateString],@(self.progress),self.error?[NSString stringWithFormat:@",error:%@",[self errorMsg]]:@""];
}
//输出状态对应的字符串
- (NSString *)stateString{
    return [self stateString:_state];
}
- (NSString *)stateString:(LWMessageState)state{
    NSString *stateString = nil;
    switch (state) {
        case LWMessageStateCreated:
            stateString = @"Created";
            break;
        case LWMessageStateSending:
            stateString = @"Sending";
            break;
        case LWMessageStateWaiting:
            stateString = @"Waiting";
            break;
        case LWMessageStateSucceed:
            stateString = @"Succeed";
            break;
        case LWMessageStateFailed:
            stateString = @"Failed";
            break;
        case LWMessageStateCancelled:
            stateString = @"Cancelled";
            break;
        default:
            break;
    }
    return stateString;
}
-(instancetype)init{
    if (self = [super init]) {
        self.name = NSStringFromClass(self.class);
        self.emitted = NO;
        
        self.state = LWMessageStateCreated;
    }
    return self;
}

-(BOOL)created{
    return _state == LWMessageStateCreated;
}
-(void)setCreated:(BOOL)created{
    if (created) {
        [self changeState:LWMessageStateCreated];
    }
}
-(BOOL)sending{
    return _state == LWMessageStateSending;
}
-(void)setSending:(BOOL)sending{
    if (sending) {
        [self changeState:LWMessageStateSending];
    }
}
-(BOOL)waiting{
    return _state == LWMessageStateWaiting;
}
-(void)setWaiting:(BOOL)waiting{
    if (waiting) {
        [self changeState:LWMessageStateWaiting];
    }
}
-(BOOL)succeed{
    return _state == LWMessageStateSucceed;
}
-(void)setSucceed:(BOOL)succeed{
    if (succeed&&!self.finished) {
        [self changeState:LWMessageStateSucceed];
    }
}
-(BOOL)failed{
    return _state == LWMessageStateFailed;
}
-(void)setFailed:(BOOL)failed{
    if (failed&&!self.finished) {
        [self changeState:LWMessageStateFailed];
    }
}
-(BOOL)cancelled{
    return _state == LWMessageStateCancelled;
}
-(void)setCancelled:(BOOL)cancelled{
    if (cancelled&&!self.finished) {
        [self changeState:LWMessageStateCancelled];
    }
}
-(BOOL)finished{
    BOOL finished = self.succeed||self.failed||self.cancelled;
    return finished;
}
-(void)setState:(LWMessageState)state{
    [self changeState:state];
}
-(void)routine{
    
}
- (void)changeState:(LWMessageState)newState{
    if (newState == _state) return;
    _state = newState;
    [self routine];
    switch (_state) {
        case LWMessageStateCreated:
            break;
        case LWMessageStateSending:
        {
            [self internalStartTimer];
            [self internalNotifySending];
        }
            break;
        case LWMessageStateWaiting:
        {
            [self internalNotifyWaiting];
        }
            break;
        case LWMessageStateSucceed:
        {
            [self internalStopTimer];
            [self internalNotifySucceed];
        }
            break;
        case LWMessageStateFailed:
        {
            [self internalStopTimer];
            [self internalNotifyFailed];
        }
            break;
        case LWMessageStateCancelled:
        {
            [self internalStopTimer];
            [self internalNotifyCancelled];
        }
            break;
    }
}

#pragma mark -
- (void)internalStartTimer{
    [_timer invalidate];
    _timer = nil;
    if(_timeoutSeconds>0){
        _timer = [NSTimer scheduledTimerWithTimeInterval:_timeoutSeconds target:self selector:@selector(didMessageTimeout) userInfo:nil repeats:NO];
    }
}
- (void)didMessageTimeout{
    _timer = nil;
    _timeout = YES;
    if(!self.failed){
        _error = [NSError errorWithMessageCode:NSURLErrorTimedOut errorMsg:nil];
        self.failed = YES;
    }
}

- (void)internalNotifyWaiting{
    if(self.whenWaiting){
        self.whenWaiting(self);
    }
    if (self.whenUpdate) {
        self.whenUpdate(self);
    }
    
}
- (void)internalNotifySucceed{
    _progress = 1;
    if(self.whenDoned){
        self.whenDoned(self);
    }
    if(self.whenSucceed){
        self.whenSucceed(self);
    }
    if (self.whenUpdate) {
        self.whenUpdate(self);
    }
}
- (void)internalNotifyFailed{
    if(self.whenDoned){
        self.whenDoned(self);
    }
    if(self.whenFailed){
        self.whenFailed(self);
    }
    if (self.whenUpdate) {
        self.whenUpdate(self);
    }
}
- (void)internalNotifyCancelled{
    if(self.whenDoned){
        self.whenDoned(self);
    }
    if(self.whenCancelled){
        self.whenCancelled(self);
    }
    if (self.whenUpdate) {
        self.whenUpdate(self);
    }
}
- (void)internalNotifySending{
    _progress = 0;
    self.emitted = YES;
    if(self.whenSending){
        self.whenSending(self);
    }
    if (self.whenUpdate) {
        self.whenUpdate(self);
    }
    
    self.waiting = YES;
}
- (void)internalStopTimer{
    [_timer invalidate];
    _timer = nil;
}
- (NSString *)errorMsg{
    NSString *errorMsg = [_error localizedFailureReason]?:[_error localizedDescription];
    return errorMsg;
}
- (void)setProgress:(CGFloat)progress{
    if(self.waiting){
        if(progress<0){
            progress = 0;
        }
        if(progress>1){
            progress = 1;
        }
        if(_progress>progress){//some error or is resending api
            
        }
        if(_progress!=progress){
            _progress = progress;
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (self.whenProgressed) {
                    self.whenProgressed(self);
                }
            });
        }
    }
}
-(void)send{
    if (self.emitted) return;
    [self changeState:LWMessageStateSending];
}
-(void)resend{
    self.emitted = NO;
    [self send];
}
-(void)cancel{
    self.state = LWMessageStateCancelled;
}
@end
