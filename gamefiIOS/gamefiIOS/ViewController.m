//
//  ViewController.m
//  gamefiIOS
//
//  Created by harden on 2021/10/19.
//

#import "ViewController.h"
#import "DataManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[DataManager sharedInstance] fetchExampleCompleteBlock:^(id reponse, NWResult *result) {
            
    }];
}


@end
