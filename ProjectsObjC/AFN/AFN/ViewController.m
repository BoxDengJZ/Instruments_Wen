//
//  ViewController.m
//  AFN
//
//  Created by dengjiangzhou on 2018/12/17.
//  Copyright © 2018 dengjiangzhou. All rights reserved.
//

#import "ViewController.h"


#import "HttpRequestManager.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [HttpRequestManager queryInfoParams: @{} success:^(id response, id data, NSString *Message) {
        
    } failure:^(NSString *statusCode, NSString *Message) {
        
    }];
}


@end
