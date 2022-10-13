//
//  CBCustomLetterKeyboard.h
//  CBKeyBoard
//
//  Created by do on 2022/10/11.
//  Copyright © 2022 CBcc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LETTER2NUM, //切换数字
    LETTERDELETE, //删除
    LETTER2SYMBOL, //切换符号
    LETTEROUTPUTSTRING, //输出
    LETTERKEYBOARDDOWN, //键盘消失
} LETTERKEYBOARDCLICKSTATUS;

NS_ASSUME_NONNULL_BEGIN

@interface CBCustomLetterKeyboard : UIView <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *qpCollectionView;//1-p
@property (nonatomic, strong) UICollectionView *alCollectionView;//a-l
@property (nonatomic, strong) UICollectionView *zmCollectionView;//z-m
//@property (nonatomic,strong) UICollectionView *symbolCollectionView;//&-@
@property (nonatomic, strong) UIButton *bigSmallBtn; //大小写按钮
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIButton *swithNumberBtn;
@property (nonatomic, strong) UIButton *keyboardDown;
@property (nonatomic, strong) UIButton *characterBtn; //字符按钮
@property (nonatomic, strong) UIButton *safeKeyboardTipBtn; //安全键盘按钮
/// 自定义键盘商标
@property (nonatomic, copy) NSString *mark;
@property (nonatomic, copy) NSString *inputString;
@property (nonatomic, copy) void (^letterKeyboardBlock)(LETTERKEYBOARDCLICKSTATUS status, NSString *text);

@end

NS_ASSUME_NONNULL_END
