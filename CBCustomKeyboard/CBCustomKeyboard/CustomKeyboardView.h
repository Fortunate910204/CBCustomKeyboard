//
//  CustomKeyboardView.h
//  CBKeyBoard
//
//  Created by do on 2022/10/11.
//  Copyright © 2022 CBcc. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, KeyboardType) {
    keyboardTypePureNumber = 0,           // 0-纯数字键盘
    keyboardTypeLetter,                   // 1-全键盘
    keyboardTypePointNumber,              // 2-带.数字键盘
    keyboardTypeRadomNumber,              // 3-随机数字键盘
    keyboardTypeSymbol                    // 4-符号键盘
};

NS_ASSUME_NONNULL_BEGIN

@protocol CustomKeyboardViewDelegate <NSObject>
@optional

- (void)customKeyboardViewOutput:(NSString *)string;
- (void)customKeyboardViewHidden;
- (void)customKeyboardViewDelete:(NSString *)string;

@end

@interface CustomKeyboardView : UIView

/// 自定义键盘商标
@property (nonatomic, strong) NSString *mark;
/// 是否有小数点（有小数点 默认隐藏字母ABC和符号@#&）
@property (nonatomic, assign) BOOL isPoint;
/// 是否纯数字1234567890
@property (nonatomic, assign) BOOL isOnlyNumber;
/// 是否随机数字1234567890
@property (nonatomic, assign) BOOL isRadomNumber;
/// 可输入的最大字符数
@property (nonatomic, assign) NSInteger maxLength;
/// 键盘类型：0-纯数字键盘，1-全键盘，2-带.数字键盘，3-随机数字键盘, 4-符号键盘
@property (nonatomic, assign) KeyboardType keyboardType;

@property (nonatomic, weak) id <CustomKeyboardViewDelegate> delegate;

- (void)clearAll;

@end

NS_ASSUME_NONNULL_END
