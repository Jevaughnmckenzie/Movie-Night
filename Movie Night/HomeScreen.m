//
//  HomeScreen.m
//  Movie Night
//
//  Created by Jevaughn McKenzie on 5/14/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

#import "HomeScreen.h"



@implementation HomeScreen

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

int main() {
    static NSArray *const iPhone4 = @[@320, @480];
    const NSArray *I_PHONE_5 = @[@320, @568];
    const NSArray *I_PHONE_7 = @[@375, @667];
    const NSArray *I_PHONE_7_PLUS = @[@414, @736];
}

-(id)init{
    if (self){
        
    }
    
    return self;
}

-(void)getPhoneType: (int) width andHeight:(int)height{
    
    // Arrays consist of the width and height dimensions in that order
    
    
    
    
    NSArray *iPhoneSizes = @[iPhone4, I_PHONE_5, I_PHONE_7, I_PHONE_7_PLUS];
    
    for (NSArray *iPhone in iPhoneSizes) {
        if ([iPhone[0] intValue] == width ){
            if ( [iPhone[1] intValue] == height ){
                _currentPhoneSize = iPhone;
            }
        }
    }
    

    
    
    
}

-(void)setHomeScreenImage:(NSArray*)screenSize{
    if ( [screenSize isEqualToArray:iPhone4] ){
        _imageFile = [[NSBundle mainBundle] pathForResource:@"bg-iphone4" ofType:@"png"];
    } else if ( [screenSize isEqualToArray:I_PHONE_5] ){
        _imageFile = [[NSBundle mainBundle] pathForResource:@"bg-iphone5" ofType:@"png"];
        
    } else if ([screenSize isEqualToArray:I_PHONE_7]){
        _imageFile = [[NSBundle mainBundle] pathForResource:@"bg-iphone6" ofType:@"png"];
    } else if ([screenSize isEqualToArray:I_PHONE_7_PLUS]) {
        _imageFile = [[NSBundle mainBundle] pathForResource:@"bg-iphone6plus" ofType:@"png"];
    }
    
    self.image = [[UIImage alloc] initWithContentsOfFile:_imageFile];
    
}

@end
