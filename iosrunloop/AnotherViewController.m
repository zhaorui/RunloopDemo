//
//  AnotherViewController.m
//  iosrunloop
//
//  Created by 赵睿 on 06/04/2017.
//  Copyright © 2017 赵睿. All rights reserved.
//

#import "AnotherViewController.h"

@interface AnotherViewController ()

@property (strong,nonatomic)NSThread * thread;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation AnotherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Create custome thread
    self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadMain) object:nil];
    [self.thread start];
}

-(void)threadMain {
    NSLog(@"thread Main in AnotherViewController");
    
    while (1) {
        [[NSRunLoop currentRunLoop] run];
        NSLog(@"loop in threadMain");
    }
}

- (IBAction)addTime:(id)sender {
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(showTimer) userInfo:nil repeats:YES];
    //添加timer到RunLoop
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
}

-(void)showTimer
{
    NSLog(@"调用time的线程：%@",[NSThread currentThread]);
    [self showText:@"-------time-------"];
}

-(void)showText:(NSString *)str
{
    NSString *text = self.textView.text;
    self.textView.text = [text stringByAppendingString:str];
}


- (IBAction)showSource:(id)sender {
    NSLog(@"main thread: %@", [NSThread currentThread]);
    [self performSelector:@selector(threadFunc) onThread:self.thread withObject:nil waitUntilDone:NO];
}

-(void) threadFunc{
    NSLog(@"from threadFunc on thread: %@", [NSThread currentThread]);
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
