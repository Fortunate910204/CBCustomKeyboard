//
//  CBRatio.m
//  CBKeyBoard
//
//  Created by do on 2022/10/9.
//  Copyright © 2022 CBcc. All rights reserved.
//

#import "CBRatio.h"

#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height

@implementation CBRatio

+ (CGFloat)widthRatio:(CGFloat)width{
    return Screen_Width / 375 * width;
}

+ (CGFloat)heightRation:(CGFloat)height{
    if (Screen_Height == 812) {
        return height *1.0;
    }
    return Screen_Height / 667 * height;
}

@end
