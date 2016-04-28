//
//  TicketSellViewController.m
//  Test
//
//  Created by zhy on 4/26/16.
//  Copyright © 2016 husor. All rights reserved.
//

#import "TicketSellViewController.h"
#import "UIViewController+print.h"
@interface TicketSellViewController ()
{
    int tickets;
    int count;
    NSThread* ticketsThreadone;
    NSThread* ticketsThreadtwo;
    NSCondition* ticketsCondition;
    NSLock *theLock;
}

@property (nonatomic, strong) NSMutableArray *greeting;

@end

@implementation TicketSellViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%@", self.printStr);
    NSLog(@"%@", self.greeting);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self threadTest];
    
    self.printStr = @"this is a category property implementation";
    NSMutableArray *arr = [[NSMutableArray alloc] initWithObjects:@"#", @"$", nil];
    self.greeting = arr;
    [arr addObject:@"e"];
    NSMutableArray *mutableArray = [arr mutableCopy];
    NSArray *arr1 = [NSArray alloc] initWithObjects:@"1", @"2", @"3", nil
    NSLog(@"");
    
}

- (void)threadTest
{
    tickets = 100;
    count = 0;
    theLock = [[NSLock alloc] init];
    // 锁对象
    ticketsCondition = [[NSCondition alloc] init];
    ticketsThreadone = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    [ticketsThreadone setName:@"Thread-1"];
    [ticketsThreadone start];
    
    
    ticketsThreadtwo = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    [ticketsThreadtwo setName:@"Thread-2"];
    [ticketsThreadtwo start];
}

- (void)run{
    while (TRUE) {
        // 上锁
        //        [ticketsCondition lock];
        [theLock lock];
        if(tickets >= 0){
//            [NSThread sleepForTimeInterval:1.0];
            count = 100 - tickets;
            NSLog(@"当前票数是:%d,售出:%d,线程名:%@",tickets,count,[[NSThread currentThread] name]);
            tickets--;
        }else{
            break;
        }
        [theLock unlock];
        //        [ticketsCondition unlock];
    }   
}

@end
