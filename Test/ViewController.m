//
//  ViewController.m
//  Test
//
//  Created by zhy on 4/26/16.
//  Copyright © 2016 husor. All rights reserved.
//

//#iOS多线程编程技术之NSThread、Cocoa NSOperation、GCD
//http://www.cocoachina.com/industry/20140520/8485.html

#import "ViewController.h"

#define kURL @"http://b1.hucdn.com/upload/show/1604/20/35887190374032_750x350.jpg!750x350.jpg"

@interface ViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadImage:) object:kURL];
    [thread start];
}

-(void)downloadImage:(NSString *) url{
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
    UIImage *image = [[UIImage alloc]initWithData:data];
    if(image == nil){
        
    }else{
//        [self performSelectorOnMainThread:@selector(updateUI:) withObject:image waitUntilDone:YES];
        [self performSelector:@selector(updateUI:) onThread:[NSThread mainThread] withObject:image waitUntilDone:YES];
    }
}

-(void)updateUI:(UIImage*) image{
    self.imageView.image = image;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:_imageView];
    }
    return _imageView;
}

@end
