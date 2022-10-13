//
//  CustomKeyboardView.m
//  CBKeyBoard
//
//  Created by do on 2022/10/11.
//  Copyright © 2022 CBcc. All rights reserved.
//

#import "CustomKeyboardView.h"
#import "CBCustomNumKeyboard.h"
#import "CBCustomLetterKeyboard.h"
#import "CBCustomSymbolKeyboard.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface CustomKeyboardView ()

@property (nonatomic, strong) CBCustomNumKeyboard *numKeyboard;
@property (nonatomic, strong) CBCustomLetterKeyboard *letterKeyboard;
@property (nonatomic, strong) CBCustomSymbolKeyboard *symbolKeyboard;

@property (nonatomic, copy) NSString *outputString;
@property (nonatomic, copy) NSString *currentOutputString;

@end

@implementation CustomKeyboardView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
        self.outputString = @"";
        self.currentOutputString = @"";
        
        [self initKeyboardView];
    }
    return self;
}

- (void)initKeyboardView {
    // 数字键盘
    [self addSubview:self.numKeyboard];
    // 字母键盘
    [self addSubview:self.letterKeyboard];
    // 符号键盘
    [self addSubview:self.symbolKeyboard];
}


#pragma mark - PublickMethod
- (void)clearAll {
    self.outputString = @"";
    self.currentOutputString = @"";
    [self padOutputingString];
}


#pragma mark - PrivateMethod
- (void)showNumPad {
    self.numKeyboard.hidden = NO;
    self.letterKeyboard.hidden = YES;
    self.symbolKeyboard.hidden = YES;
}

- (void)showLetterPad {
    self.numKeyboard.hidden = YES;
    self.letterKeyboard.hidden = NO;
    self.symbolKeyboard.hidden = YES;
}

- (void)showSymbolPad {
    self.numKeyboard.hidden = YES;
    self.letterKeyboard.hidden = YES;
    self.symbolKeyboard.hidden = NO;
}

- (void)padOutputingString {
    if (self.outputString.length >= self.maxLength) {
        self.outputString = [self.outputString substringToIndex:self.maxLength];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(customKeyboardViewOutput:)]) {
        [self.delegate customKeyboardViewOutput:self.outputString];
    }
}

- (void)padHidden {
    if (self.delegate && [self.delegate respondsToSelector:@selector(customKeyboardViewHidden)]) {
        [self.delegate customKeyboardViewHidden];
    }
}

- (void)padDelete {
    if(self.outputString.length == 0){
        return;
    }
    self.outputString = [self.outputString substringToIndex:[self.outputString length] - 1];
    [self padOutputingString];
}


#pragma mark - Set
- (void)setMark:(NSString *)mark {
    _mark = mark;
    [self.letterKeyboard.safeKeyboardTipBtn setTitle:mark forState:UIControlStateNormal];
}

- (void)setKeyboardType:(KeyboardType)keyboardType {
    /// 键盘类型：0-纯数字键盘，1-全键盘，2-带.数字键盘，3-随机数字键盘, 4-符号键盘
    _keyboardType = keyboardType;
    if (keyboardType == keyboardTypePureNumber) {
        [self showNumPad];
        self.numKeyboard.isOnlyNumber = YES;
    }
    else if (keyboardType == keyboardTypeLetter) {
        [self showLetterPad];
    }
    else if (keyboardType == keyboardTypePointNumber) {
        [self showNumPad];
        self.numKeyboard.isPoint = YES;
    }
    else if (keyboardType == keyboardTypeRadomNumber) {
        [self showNumPad];
        self.numKeyboard.isRadomNumber = YES;
    }
    else if (keyboardType == keyboardTypeSymbol) {
        [self showSymbolPad];
    }
}

- (void)setMaxLength:(NSInteger)maxLength {
    _maxLength = maxLength;
}


#pragma mark - Lazyload
- (CBCustomNumKeyboard *)numKeyboard {
    if (!_numKeyboard) {
        __weak typeof(self) weakSelf = self;
        _numKeyboard = [[CBCustomNumKeyboard alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT / 667 * 216)];
        _numKeyboard.numKeyboardBlock = ^(NUMKEYBOARDCLICKSTATUS status, NSString * _Nonnull text) {
            if (status == NUM2LETTER) {
                [weakSelf showLetterPad];
            }
            else if (status == NUM2SYMBOL) {
                [weakSelf showSymbolPad];
            }
            else if (status == NUMOUTPUTSTRING) {
                weakSelf.currentOutputString = text;
                weakSelf.outputString = [NSString stringWithFormat:@"%@%@", weakSelf.outputString, text];
                [weakSelf padOutputingString];
            }
            else if (status == NUMKEYBOARDDOWN) {
                [weakSelf padHidden];
            }
            else if (status == NUMDELETE) {
                [weakSelf padDelete];
            }
        };
    }
    return _numKeyboard;
}

- (CBCustomLetterKeyboard *)letterKeyboard {
    if (!_letterKeyboard) {
        __weak typeof(self) weakSelf = self;
        _letterKeyboard = [[CBCustomLetterKeyboard alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT / 667 * 216)];
        _letterKeyboard.letterKeyboardBlock = ^(LETTERKEYBOARDCLICKSTATUS status, NSString * _Nonnull text) {
            if (status == LETTER2NUM) {
                [weakSelf showNumPad];
            }
            else if (status == LETTER2SYMBOL) {
                [weakSelf showSymbolPad];
            }
            else if (status == LETTEROUTPUTSTRING) {
                weakSelf.currentOutputString = text;
                weakSelf.outputString = [NSString stringWithFormat:@"%@%@", weakSelf.outputString, text];
                [weakSelf padOutputingString];
            }
            else if (status == LETTERKEYBOARDDOWN) {
                [weakSelf padHidden];
            }
            else if (status == LETTERDELETE) {
                [weakSelf padDelete];
            }
        };
    }
    return _letterKeyboard;
}

- (CBCustomSymbolKeyboard *)symbolKeyboard {
    if (!_symbolKeyboard) {
        __weak typeof(self) weakSelf = self;
        _symbolKeyboard = [[CBCustomSymbolKeyboard alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT / 667 * 216)];
        _symbolKeyboard.symbolKeyboardBlock = ^(SYMBOLKEYBOARDCLICKSTATUS status, NSString * _Nonnull text) {
            if (status == SYMBOL2NUM) {
                [weakSelf showNumPad];
            }
            else if (status == SYMBOL2LETTER) {
                [weakSelf showLetterPad];
            }
            else if (status == SYMBOLOUTPUTSTRING) {
                weakSelf.currentOutputString = text;
                weakSelf.outputString = [NSString stringWithFormat:@"%@%@", weakSelf.outputString, text];
                [weakSelf padOutputingString];
            }
            else if (status == SYMBOLKEYBOARDDOWN) {
                [weakSelf padHidden];
            }
            else if (status == SYMBOLDELETE) {
                [weakSelf padDelete];
            }
        };
    }
    return _symbolKeyboard;
}

@end
