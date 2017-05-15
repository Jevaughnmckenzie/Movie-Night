//
//  HomeScreen.m
//  Movie Night
//
//  Created by Jevaughn McKenzie on 5/14/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

#import "HomeScreen.h"

static const int I_PHONE_4_WIDTH = 320;
static const int I_PHONE_4_HEIGHT = 480;
static const int I_PHONE_5_WIDTH = 320;
static const int I_PHONE_5_HEIGHT = 568;
static const int I_PHONE_7_WIDTH = 375;
static const int I_PHONE_7_HEIGHT = 667;
static const int I_PHONE_7_PLUS_WIDTH = 414;
static const int I_PHONE_7_PLUS_HEIGHT = 736;


@implementation HomeScreen

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)init{
    if (self){
        
    }
    
    return self;
}

-(void)getPhoneType: (int) width andHeight:(int)height{
    
    // Arrays consist of the width and height dimensions in that order
    
    
    
    
    NSArray *iPhoneSizes = @[
      @[@(I_PHONE_4_WIDTH), @(I_PHONE_4_HEIGHT)],
      @[@(I_PHONE_5_WIDTH), @(I_PHONE_5_HEIGHT)],
      @[@(I_PHONE_7_WIDTH), @(I_PHONE_7_HEIGHT)],
      @[@(I_PHONE_7_PLUS_WIDTH), @(I_PHONE_7_PLUS_HEIGHT)]
  ];
    
    for ( NSArray *iPhone in iPhoneSizes){
        if ( [iPhone[0] intValue] == width ){
            if ( [iPhone[1] intValue] == height ){
                _currentPhoneSize = iPhone;
            }
        }
    }
}

-(void)setHomeScreenImage:(NSArray*)screenSize{
    if ( [screenSize isEqualToArray:@[@(I_PHONE_4_WIDTH), @(I_PHONE_4_HEIGHT)]] ){
        _imageFile = [[NSBundle mainBundle] pathForResource:@"bg-iphone4" ofType:@"png"];
    } else if ( [screenSize isEqualToArray:@[@(I_PHONE_5_WIDTH), @(I_PHONE_5_HEIGHT)]] ){
        _imageFile = [[NSBundle mainBundle] pathForResource:@"bg-iphone5" ofType:@"png"];
        
    } else if ([screenSize isEqualToArray:@[@(I_PHONE_7_WIDTH), @(I_PHONE_7_HEIGHT)]]){
        _imageFile = [[NSBundle mainBundle] pathForResource:@"bg-iphone6" ofType:@"png"];
    } else if ([screenSize isEqualToArray:@[@(I_PHONE_7_PLUS_WIDTH), @(I_PHONE_7_PLUS_HEIGHT)]]) {
        _imageFile = [[NSBundle mainBundle] pathForResource:@"bg-iphone6plus" ofType:@"png"];
    }
    
    self.image = [[UIImage alloc] initWithContentsOfFile:_imageFile];
    
}

@end
