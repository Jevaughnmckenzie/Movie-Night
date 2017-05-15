//
//  HomeScreen.h
//  Movie Night
//
//  Created by Jevaughn McKenzie on 5/14/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface HomeScreen : UIImageView



@property (nonatomic, strong) NSArray *currentPhoneSize;
@property (nonatomic, strong) NSString *imageFile;

const NSArray *I_PHONE_5;


//@property (nonatomic, weak) UIImageView *backgroundImage;

-(void)getPhoneType: (int) width andHeight:(int)height;

@end
