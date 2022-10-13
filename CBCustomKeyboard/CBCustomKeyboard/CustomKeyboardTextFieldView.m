//
//  CustomKeyboardTextFieldView.m
//  CustomKeyboard
//
//  Created by do on 2022/10/12.
//

#import "CustomKeyboardTextFieldView.h"
#import "CustomKeyboardView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface CustomKeyboardTextFieldView () <CustomKeyboardViewDelegate>

@property (nonatomic, strong) CustomKeyboardView *customKeyboard;

@end

@implementation CustomKeyboardTextFieldView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clearButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
        self.clearButton.center = CGPointMake(frame.size.width-10, frame.size.height/2);
        [self.clearButton setImage:[UIImage imageNamed:@"Resources.bundle/ClearButton.png"] forState:UIControlStateNormal];
        self.clearButton.hidden = YES;
        [self addSubview:self.clearButton];
        [self.clearButton addTarget:self action:@selector(clearButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, frame.size.width-18, frame.size.height)];
        self.textField.inputView = self.customKeyboard;
        [self addSubview:self.textField];
    }
    return self;
}

- (void)clearButtonClick {
    [self clearAll];
}

- (void)clearAll {
    self.textField.text = @"";
    self.clearButton.hidden = YES;
    [self.customKeyboard clearAll];
    if (self.customKeyboardTextFieldViewClearBlock) {
        self.customKeyboardTextFieldViewClearBlock();
    }
}

- (void)setIsShowClearButton:(BOOL)isShowClearButton {
    _isShowClearButton = isShowClearButton;
}

- (void)setAttributedPlaceholderString:(NSMutableAttributedString *)attributedPlaceholderString {
    self.textField.attributedPlaceholder = attributedPlaceholderString;
}

- (void)setTextFieldFont:(UIFont *)textFieldFont {
    self.textField.font = textFieldFont;
}

- (void)setTextFieldFontColor:(UIColor *)textFieldFontColor {
    self.textField.textColor = textFieldFontColor;
}

- (void)setMaxLength:(NSInteger)maxLength {
    self.customKeyboard.maxLength = maxLength;
}

- (void)setTextFieldKeyboardType:(NSInteger)textFieldKeyboardType {
    _textFieldKeyboardType = textFieldKeyboardType;
    self.customKeyboard.keyboardType = textFieldKeyboardType;
}


#pragma mark - CustomKeyboardViewDelegate
- (void)customKeyboardViewOutput:(NSString *)string {
    self.textField.text = string;
    if (_isShowClearButton) {
        self.clearButton.hidden = !string.length;
    }
}

- (void)customKeyboardViewHidden {
    [self.textField resignFirstResponder];
}

- (void)customKeyboardViewDelete:(NSString *)string {
    
}


#pragma mark - LazyLoad
- (CustomKeyboardView *)customKeyboard {
    if (!_customKeyboard){
        _customKeyboard = [[CustomKeyboardView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - SCREEN_HEIGHT / 667 * 216, SCREEN_WIDTH, SCREEN_HEIGHT / 667 * 216)];
        _customKeyboard.delegate = self;
        _customKeyboard.mark = @"xxx安全键盘";
        _customKeyboard.maxLength = 999;
        _customKeyboard.keyboardType = keyboardTypeLetter;
    }
    return _customKeyboard;
}

@end
