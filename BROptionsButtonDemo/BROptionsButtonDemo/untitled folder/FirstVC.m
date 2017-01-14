//
//  FirstVC.m
//  BROptionsButtonDemo
//
//  Created by Basheer Malaa on 3/10/14.
//  Copyright (c) 2014 Basheer Malaa. All rights reserved.
//

#import "FirstVC.h"
#import "Define.h"

@interface FirstVC ()

@end

@implementation FirstVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    LOG_CURRENT_METHOD;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //NSURLSessionは非同期処理であるため、disppath_semaphore_tを使って同期処理にする
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    NSURL * url = [[NSURL alloc] initWithString:@"http://35.166.133.39/cgi-bin/chargeResult.py"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    __block NSDictionary *jsonResponse = nil;
    //ephemeralSessionConfiguration: NSURLSessionが破棄されたタイミングで全てのデータが消去
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionTask *task = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            // Success
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSError *jsonError;
                jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                if (jsonError) {
                    // Error Parsing JSON
                    NSLog(@"Json Error!");
                    
                } else {
                    // Success Parsing JSON
                    NSLog(@"Got results successfully!");
                }
            }  else {
                //Web server is returning an error
                NSLog(@"Web Server Error!");
            }
        } else {
            // Fail
            NSLog(@"error : %@", error.description);
        }
        
        dispatch_semaphore_signal(semaphore);
    }];
    
    [task resume];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"the end");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
