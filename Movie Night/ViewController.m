//
//  ViewController.m
//  Movie Night
//
//  Created by Jevaughn McKenzie on 5/14/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

#import "ViewController.h"
#import "HomeScreen.h"

enum phoneType{
    iPhone4, 
    iPhone5,
    iPhone6,
    iPhone7
};



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    
//    UIImage *image = [[UIImage alloc] initWithContentsOfFile:imageFile];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//    imageView.frame = self.view.bounds;
//    [self.view addSubview:imageView];
    [self setMainPageViews];
    [_homeScreen getPhoneType:self.view.frame.size.width andHeight:self.view.frame.size.height];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setMainPageViews{
    
    self.homeScreen = [[HomeScreen alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_homeScreen];
    
}





@end
