//
//  LWMessage.h
//  LWMessage
//  消息机制 作用监听任务状态
//  Created by 程恒盛 on 17/1/16.
//  Copyright © 2017年 力王. All rights reserved.
//  抽象任务

#import <UIKit/UIKit.h>

/**
 ----------------------------------------------------------------------
 moon:
 
 消息状态变更的处理逻辑如下:
 1.执行executor对象的preExecuteMessage方法,如果返回NO,状态变更处理结束.这种情况一般用在preExecuteMessage中,状态又进行了变更,此时后续的处理已经不需要了.
 2.执行executor对象的executeMessage方法.如果在执行过程中,又变更了消息状态(如调用self.failed=YES),此时该新状态是存储在nextState中的,并不会立刻改变当前的state.
 3.执行executor对象的postExecuteMessage方法.
 4.在executor对象的处理逻辑结束后,如果状态发生改变了,那直接返回,停止后面的逻辑.
 5.对self.state,调用相应的whenXXX(self);block方法.
 遍历self.responders,调用其对应的preRespondMessage,respondMessage,postRespondMessage等方法.如果preExecuteMessage返回了NO,则该responder的respondMessage与postRespondMessage方法不会执行,但是不会影响其他的responder
 ----------------------------------------------------------------------
 消息进度变化的处理逻辑如下:(前提:消息要处理wating状态时,才可能进行进度的改变)
 1.执行executor对象的executeMessageProgress:方法
 2.执行self.whenProgressed(self);语句
 3.遍历self.responders,调用方法respondMessageProgress:
 ----------------------------------------------------------------------
 对于单例的消息,它可以在消息完成后,再次处于发送中的状态,从而达到消息复用的目的.
 对于一个消息,被其他多个消息依赖的情况,当它完成之后,被从messagequeue中移除,但它还被依赖消息持有着,等待被依赖消息的释放.
 消息状态的变化,是延迟的,在messagequeue的定时器中执行.
 */

@interface LWMessage : NSObject
{
    @protected
    NSTimer *_timer;
    NSError *_error;
}
typedef void(^LWMessageBlock)(void);//回调
typedef void(^LWMessageBlockM)(__kindof LWMessage *msg);//回调

typedef enum {
    LWMessageStateCreated,//消息被创建
    LWMessageStateSending,//消息正在发送
    LWMessageStateWaiting,//消息正在等待回应
    LWMessageStateSucceed,//消息处理成功(本地或网络)
    LWMessageStateFailed,//消息处理失败(本地或网络)
    LWMessageStateCancelled//消息被取消了
}LWMessageState;//消息状态


@property(nonatomic,strong) NSString *name;//消息名称
@property(nonatomic,readonly) BOOL timeout;//是否超时了
@property(nonatomic,assign) NSTimeInterval timeoutSeconds;//超时时间,默认是0,不设置超时时间
@property(nonatomic,assign) BOOL emitted;//标记消息是否已经被发送过了

@property (nonatomic,assign  ) CGFloat progress;//消息的处理进度
@property (nonatomic,assign  ) BOOL    created;//是否在创建状态
@property (nonatomic,assign  ) BOOL    sending;//是否在发送中状态
@property (nonatomic,assign  ) BOOL    waiting;//是否在等待状态
@property (nonatomic,assign  ) BOOL    succeed;//是否在成功状态
@property (nonatomic,assign  ) BOOL    failed;//是否在失败状态
@property (nonatomic,assign  ) BOOL    cancelled;//是否在取消状态
@property (nonatomic,readonly) BOOL    finished;//是否处于完成状

@property(nonatomic,readonly) NSError *error;//错误信息
@property(nonatomic,readonly) NSString *errorMsg;//错误文字信息
@property(nonatomic,assign) LWMessageState state;//消息状态 状态变回会执行相应的block

@property(nonatomic,copy) LWMessageBlockM whenUpdate;//状态变化时的回调
@property(nonatomic,copy) LWMessageBlockM whenSending;//发送后的回调
@property(nonatomic,copy) LWMessageBlockM whenWaiting;//进入等待后的回调
@property(nonatomic,copy) LWMessageBlockM whenSucceed;//处理成功后的回调
@property(nonatomic,copy) LWMessageBlockM whenFailed;//处理失败后的回调
@property(nonatomic,copy) LWMessageBlockM whenCancelled;//被取消后的回调
@property(nonatomic,copy) LWMessageBlockM whenDoned;//succeed,failed,cancel时回调
@property(nonatomic,copy) LWMessageBlockM whenProgressed;//进度变化时的回调

- (void)send;
- (void)resend;//将消息重新发送
//取消消息,会马上移除掉等待的其他消息
- (void)cancel;

/**
 *  子类重写,用于实例消息状态的变化 
 */
- (void)routine;
@end
