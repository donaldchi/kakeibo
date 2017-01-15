#import "SecondVC.h"
#import <AFNetworking/AFNetworking.h>

@interface SecondVC () <UITextFieldDelegate>
@end

@implementation SecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _receiptImage.frame = CGRectMake(20, 20, SCREEN_WIDTH-40, SCREEN_HEIGHT/2-5);
    _chooseImage.frame = CGRectMake(SCREEN_WIDTH/2-80, SCREEN_HEIGHT*3/4-55, 160, 30);
    _sendImage.frame = CGRectMake(SCREEN_WIDTH/2-80, SCREEN_HEIGHT*3/4-15, 160, 30);
    isImageChosed = NO;
    
    NSLog(@"navi: %@", self.navigationController);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (IBAction) sendImagePressed:(id)sender {
    LOG_CURRENT_METHOD;

    UIImage *image = _receiptImage.currentBackgroundImage;  // name of the image
    
    NSData *imageData =  UIImagePNGRepresentation(image);  // convert your image into data
    
    NSString *urlString = [NSString stringWithFormat:@"http://35.165.106.145/cgi-bin/receiveReceipt.py"];  // enter your url to upload
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];  // allocate AFHTTPManager
    // ここでserializerをデフォルトから変更している。
    NSMutableSet *newAcceptableContentTypes = [NSMutableSet setWithSet:manager.responseSerializer.acceptableContentTypes] ;
    [newAcceptableContentTypes addObject:@"multipart/form-data"];
    manager.responseSerializer.acceptableContentTypes = newAcceptableContentTypes ;
    
    
    [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {  // POST DATA USING MULTIPART CONTENT TYPE
        [formData appendPartWithFileData:imageData
                                    name:@"img"
                                fileName:@"image.png" mimeType:@"image/png"];   // add image to formData
        
    } progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        receipt_content = NULL;
        [self getImageAnalyzedResult];

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);   // Gives Error
    }];
}

- (void) getImageAnalyzedResult {
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://35.165.106.145/cgi-bin/analyze.py"]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        receipt_content = [array valueForKeyPath:@"description"];
        NSLog(@"receipt: %@", receipt_content);
        if(receipt_content!=nil) {
            ReceiptContents *receipt = [[ReceiptContents alloc] init];
            [self presentViewController:receipt animated:YES completion:NULL];
            receipt.shopName.text = receipt_content;
            receipt.shopName.frame = CGRectMake(20, 20, SCREEN_WIDTH-40, SCREEN_HEIGHT-100);
        }
    }] resume];
}

#pragma mark - Action
// 画像選択後の処理
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    // カメラロールの画面が閉じられたあとの処理を記述
    [self dismissViewControllerAnimated:YES completion:^{
        // ①選択した画像をUIimageViewに表示
        [_receiptImage setBackgroundImage:image forState:UIControlStateNormal];
       // [_receiptImage.currentBackgroundImage ];
        [_receiptImage setTitle:@"" forState:UIControlStateNormal];
    }];
}
- (IBAction)receiptImagePressed:(id)sender {
    LOG_CURRENT_METHOD;
    if(!isImageChosed) {
        UIImagePickerControllerSourceType sourceType
        = UIImagePickerControllerSourceTypePhotoLibrary;
        if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.sourceType = sourceType;
            picker.delegate = self;
            [self presentViewController:picker animated:YES completion:NULL];
        }
        
        isImageChosed = YES;
    } else {
        
        if(_receiptImage.frame.size.height < (SCREEN_HEIGHT-100)) {
            _receiptImage.frame = CGRectMake(20, 20, SCREEN_WIDTH-40, SCREEN_HEIGHT-100);
            [_sendImage setTitle:@"" forState:UIControlStateNormal];
            [_chooseImage setTitle:@"" forState:UIControlStateNormal];
            
        } else {
            _receiptImage.frame = CGRectMake(20, 20, SCREEN_WIDTH-40, SCREEN_HEIGHT/2-5);
            [_sendImage setTitle:@"サーバーに送る" forState:UIControlStateNormal];
            [_chooseImage setTitle:@"イメージ選択" forState:UIControlStateNormal];
        }

        
    }
}
- (IBAction)chooseImagePressed:(id)sender {
    UIImagePickerControllerSourceType sourceType
    = UIImagePickerControllerSourceTypePhotoLibrary;
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = sourceType;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:NULL];
    }
    isImageChosed = YES;
}
@end
