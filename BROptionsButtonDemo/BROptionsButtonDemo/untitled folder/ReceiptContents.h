//
//  ReceiptContents.h
//  BROptionsButtonDemo
//
//  Created by chi on 15/01/2017.
//  Copyright © 2017 Basheer Malaa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceiptContents : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    UITableView *resultView;
}
@property (nonatomic, weak) IBOutlet NSString * contents;
@property (nonatomic, retain) IBOutlet UITableView *resultView;
@property (nonatomic, weak) IBOutlet UILabel * shopName;
@end
