//
//  SecondVC.h
//  BROptionsButtonDemo
//
//  Created by Basheer Malaa on 3/10/14.
//  Copyright (c) 2014 Basheer Malaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabBarController.h"
#import "Define.h"
#import "ReceiptContents.h"

@interface SecondVC : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource>{
    BOOL * isImageChosed;
    NSString * receipt_content;
}

@property (nonatomic, weak) id<CommonDelegate> commonDelegate;

@property (nonatomic, weak) IBOutlet UINavigationBar * naviBar;
@property (nonatomic, weak) IBOutlet UIButton * chooseImage;
- (IBAction)chooseImagePressed:(id)sender;

@property (nonatomic, weak) IBOutlet UIButton * receiptImage;
- (IBAction)receiptImagePressed:(id)sender;

@property (nonatomic, weak) IBOutlet UIButton * sendImage;
- (IBAction)sendImagePressed:(id)sender;
@end
