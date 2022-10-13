//
//  CBCustomSymbolKeyboard.h
//  CBKeyBoard
//
//  Created by do on 2022/10/11.
//  Copyright © 2022 CBcc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SYMBOL2NUM, //切换数字 字母
    SYMBOLDELETE, //删除
    SYMBOL2LETTER, //字母
    SYMBOLOUTPUTSTRING, //输出
    SYMBOLKEYBOARDDOWN, //键盘消失
} SYMBOLKEYBOARDCLICKSTATUS;

NS_ASSUME_NONNULL_BEGIN

@interface CBCustomSymbolKeyboard : UIView <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *symbolOneCollectionView;//[  =
@property (nonatomic,strong) UICollectionView *symbolTwoCollectionView;//_  `
@property (nonatomic,strong) UICollectionView *symbolThreeCollectionView;//.  :
@property (nonatomic,strong) UICollectionView *symbolFourCollectionView;//&  @
@property (nonatomic,strong) UIButton *letterBtn; //字母按钮
@property (nonatomic,strong) UIButton *deleteBtn;
@property (nonatomic,strong) UIButton *swithNumberBtn;
@property (nonatomic,strong) UIButton *keyboardDown;
@property (nonatomic,strong) UIButton *characterBtn;
@property (nonatomic,copy) NSString *inputString;
@property (nonatomic, copy) void (^symbolKeyboardBlock)(SYMBOLKEYBOARDCLICKSTATUS status, NSString *text);

@end

NS_ASSUME_NONNULL_END
