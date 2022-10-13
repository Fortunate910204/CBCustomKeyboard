//
//  CustomKeyboardTextFieldView.h
//  CustomKeyboard
//
//  Created by do on 2022/10/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomKeyboardTextFieldView : UIView

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *clearButton;

/// 占位符
@property (nonatomic, copy) NSMutableAttributedString *attributedPlaceholderString;
/// 字体
@property (nonatomic, strong) UIFont *textFieldFont;
/// 字体颜色
@property (nonatomic, strong) UIColor *textFieldFontColor;
/// 调起键盘类型：0-纯数字键盘，1-全键盘，2-带.数字键盘，3-随机数字键盘, 4-符号键盘
@property (nonatomic, assign) NSInteger textFieldKeyboardType;
/// 可输入的最大字符数
@property (nonatomic, assign) NSInteger maxLength;

/// 是否显示一键清除clear button
@property (nonatomic, assign) BOOL isShowClearButton;
- (void)clearAll;

@property (nonatomic, copy) void (^customKeyboardTextFieldViewClearBlock)(void);

@end

NS_ASSUME_NONNULL_END
