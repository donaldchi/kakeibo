
#import "MainTabBarController.h"
#import "BROptionsButton.h"
#import "SecondVC.h"

@interface MainTabBarController ()<BROptionButtonDelegate, CommonDelegate>
@property (nonatomic, strong) BROptionsButton *brOptionsButton;
@end

@implementation MainTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    SecondVC *second = [self.viewControllers objectAtIndex:1];
    second.commonDelegate = self;
    
	// Do any additional setup after loading the view.
    BROptionsButton *brOption = [[BROptionsButton alloc] initWithTabBar:self.tabBar forItemIndex:1 delegate:self];
    self.brOptionsButton = brOption;
    [brOption setImage:[UIImage imageNamed:@"input_main.png"] forBROptionsButtonState:BROptionsButtonStateNormal];
    [brOption setImage:[UIImage imageNamed:@"close"] forBROptionsButtonState:BROptionsButtonStateOpened];
}

#pragma mark - BROptionsButtonState

- (NSInteger)brOptionsButtonNumberOfItems:(BROptionsButton *)brOptionsButton {
    return 3;
}

- (UIImage*)brOptionsButton:(BROptionsButton *)brOptionsButton imageForItemAtIndex:(NSInteger)index {
    UIImage *image;
    if(index == 0)
        image = [UIImage imageNamed:@"write.png"];
    else if (index ==1)
        image = [UIImage imageNamed:@"tokei.png"];
    else if (index ==2)
        image = [UIImage imageNamed:@"camera.png"];
    return image;
}


- (void)brOptionsButton:(BROptionsButton *)brOptionsButton didSelectItem:(BROptionItem *)item {
    [self setSelectedIndex:brOptionsButton.locationIndexInTabBar];
    NSLog(@"Button No: %d pressed!", item.index);
}

#pragma mark - CommonDelegate 

- (void)changeBROptionsButtonLocaitonTo:(NSInteger)location animated:(BOOL)animated {
    if(location < self.tabBar.items.count) {
        [self.brOptionsButton setLocationIndexInTabBar:location animated:YES];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"wrong index" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

@end
