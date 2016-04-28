//
//  UIViewController+print.m
//  Test
//
//  Created by zhy on 4/28/16.
//  Copyright © 2016 husor. All rights reserved.
//

#import "UIViewController+print.h"
#import <objc/runtime.h>

@implementation UIViewController (print)

- (void)setPrintStr:(NSString *)printStr
{
    objc_setAssociatedObject(self, @"_printStr", printStr, OBJC_ASSOCIATION_ASSIGN);
}

- (NSString *)printStr
{
    return objc_getAssociatedObject(self, @"_printStr");
}
@end
