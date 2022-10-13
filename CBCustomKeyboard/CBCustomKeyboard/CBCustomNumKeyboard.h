//
//  CBCustomNumKeyboard.h
//  CBKeyBoard
//
//  Created by do on 2022/10/11.
//  Copyright © 2022 CBcc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    NUMDELETE, //删除
    NUM2SYMBOL, //符号
    NUM2LETTER, //字母
    NUMOUTPUTSTRING, //输出
    NUMKEYBOARDDOWN, //键盘消失
} NUMKEYBOARDCLICKSTATUS;

NS_ASSUME_NONNULL_BEGIN

@interface CBCustomNumKeyboard : UIView <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *numberCollection; //数字CollectionView
@property (nonatomic, strong) UIButton *deleteBtn; //删除按钮
@property (nonatomic, strong) UIButton *keyboardDown; //键盘隐藏按钮
@property (nonatomic, strong) NSString *inputString; //输出的字符串
@property (nonatomic, copy) void (^numKeyboardBlock)(NUMKEYBOARDCLICKSTATUS status, NSString *text);

@property (nonatomic, assign) BOOL isPoint;
@property (nonatomic, assign) BOOL isOnlyNumber;
@property (nonatomic, assign) BOOL isRadomNumber;

@end

NS_ASSUME_NONNULL_END
