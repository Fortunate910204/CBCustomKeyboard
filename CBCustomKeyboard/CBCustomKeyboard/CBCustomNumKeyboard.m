//
//  CBCustomNumKeyboard.m
//  CBKeyBoard
//
//  Created by do on 2022/10/11.
//  Copyright © 2022 CBcc. All rights reserved.
//

#import "CBCustomNumKeyboard.h"
#import "CBRatio.h"
#import "CBLetterCCell.h"

#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height

@implementation CBCustomNumKeyboard
{
    CGRect cb_frame;

    int horSplitNum;
    int verSplitNum;
    CGFloat viewWidth;
    CGFloat viewHeight;
    CGFloat lineSpacing;
    
    NSArray *numberArray;
}

#pragma mark ---lazy
- (UICollectionView *)numberCollection {
    if(!_numberCollection){
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
        flowlayout.itemSize = CGSizeMake((viewWidth - lineSpacing*3)/horSplitNum, (viewHeight - lineSpacing*3) / verSplitNum);
        flowlayout.sectionInset = UIEdgeInsetsMake(0.5, 0, 0, 0);
        flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _numberCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, viewWidth - (viewWidth / horSplitNum), viewHeight) collectionViewLayout:flowlayout];
        _numberCollection.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
        _numberCollection.delegate = self;
        _numberCollection.dataSource = self;
        _numberCollection.scrollEnabled = NO;
        [_numberCollection registerClass:[CBLetterCCell class] forCellWithReuseIdentifier:@"CBLetterCCell"];
    }
    return _numberCollection;
}
- (UIButton *)deleteBtn{
    if (!_deleteBtn){
        _deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.numberCollection.bounds.size.width+lineSpacing, lineSpacing, cb_frame.size.width / 4, viewHeight/2)];
        _deleteBtn.backgroundColor = [UIColor whiteColor];
        [_deleteBtn setImage:[UIImage imageNamed:@"Resources.bundle/keyDelete.png"] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}
- (UIButton *)keyboardDown{
    if (!_keyboardDown){
        _keyboardDown = [[UIButton alloc]initWithFrame:CGRectMake(self.numberCollection.bounds.size.width+lineSpacing, _deleteBtn.bounds.size.height+lineSpacing*2, cb_frame.size.width / 4, viewHeight/2)];
        _keyboardDown.backgroundColor = [UIColor whiteColor];
        [_keyboardDown setImage:[UIImage imageNamed:@"Resources.bundle/keyboardDown.png"] forState:UIControlStateNormal];
        [_keyboardDown addTarget:self action:@selector(keyboardDownnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _keyboardDown;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        cb_frame = frame;
        self.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
        [self InitializeProperty];
        [self initNumberKeyboardView];
    }
    return self;
}

- (void)InitializeProperty {
    horSplitNum = 4;
    verSplitNum = 4;
    viewWidth = cb_frame.size.width;
    viewHeight = cb_frame.size.height;
    lineSpacing = 0.5;
    numberArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"ABC",@"0",@"@#&"];
    self.inputString = @"";
}

- (void)setIsPoint:(BOOL)isPoint {
    _isPoint = isPoint;
    numberArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",self.isPoint ? @"" : @"ABC",@"0",self.isPoint ? @"." : @"@#&"];
    [self.numberCollection reloadData];
}

- (void)setIsOnlyNumber:(BOOL)isOnlyNumber {
    _isOnlyNumber = isOnlyNumber;
    numberArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",self.isOnlyNumber ? @"" : @"ABC",@"0",self.isOnlyNumber ? @"" : @"@#&"];
    [self.numberCollection reloadData];
}


- (void)initNumberKeyboardView{
    [self addSubview:self.numberCollection];
    [self addSubview:self.deleteBtn];
    [self addSubview:self.keyboardDown];
}


#pragma mark ---UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 12;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CBLetterCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CBLetterCCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    [cell initCell:indexPath.row wihtDataSource:numberArray];
    return cell;
}

#pragma mark ---UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 9: //切换英文键盘
        {
            if(!self.isPoint && !self.isOnlyNumber){
                if (self.numKeyboardBlock != nil){
                    self.numKeyboardBlock(NUM2LETTER,@"");
                }
            }
        }
            break;
        case 11: //切换符号键盘
        {
            if (self.isPoint){
                self.numKeyboardBlock(NUMOUTPUTSTRING,@".");
            }
            else if (self.isOnlyNumber) {
                
            } else {
                if (self.numKeyboardBlock != nil){
                    self.numKeyboardBlock(NUM2SYMBOL,@"");
                }
            }
        }
            break;
        case 10: //输入数字0
            self.numKeyboardBlock(NUMOUTPUTSTRING,@"0");
            break;
        default: //输入123456789
        {
            self.numKeyboardBlock(NUMOUTPUTSTRING,[NSString stringWithFormat:@"%d",[numberArray[indexPath.row] intValue]]);
        }
            break;
    }
}

#pragma mark ---UICollectionViewDelegateFlowLayout
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.5;
}


#pragma mark --数字 删除
- (void)deleteBtnClick{
    if (self.numKeyboardBlock != nil){
        self.numKeyboardBlock(NUMDELETE,@"");
    }
}
#pragma mark --键盘 收起
- (void)keyboardDownnClick{
    if (self.numKeyboardBlock != nil){
        self.numKeyboardBlock(NUMKEYBOARDDOWN,@"");
    }
}


@end
