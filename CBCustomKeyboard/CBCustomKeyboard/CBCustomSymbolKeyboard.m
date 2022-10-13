//
//  CBCustomSymbolKeyboard.m
//  CBKeyBoard
//
//  Created by do on 2022/10/11.
//  Copyright © 2022 CBcc. All rights reserved.
//

#import "CBCustomSymbolKeyboard.h"
#import "CBRatio.h"
#import "CBLetterCCell.h"

#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height

@implementation CBCustomSymbolKeyboard
{
    CGRect cb_frame;
    CGFloat viewWidth;
    CGFloat viewHeight;
    CGFloat collectionViewSpacing;
    CGFloat collectionViewHeight;
    CGFloat itemSizeSpacing;
    
    NSArray <NSString*>*symbolOneArray;
    NSArray <NSString*>*symbolTwoArray;
    NSArray <NSString*>*symbolThreeArray;
    NSArray <NSString*>*symbolFourArray;
}

#pragma mark -lazy
- (UICollectionView *)symbolOneCollectionView{
    if(!_symbolOneCollectionView){
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
        flowlayout.itemSize = CGSizeMake((viewWidth - itemSizeSpacing*11)/10, collectionViewHeight);
        flowlayout.sectionInset = UIEdgeInsetsMake(0, [CBRatio widthRatio:5], 0, [CBRatio widthRatio:5]);
        flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _symbolOneCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, collectionViewSpacing, cb_frame.size.width, collectionViewHeight) collectionViewLayout:flowlayout];
        _symbolOneCollectionView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
        _symbolOneCollectionView.delegate = self;
        _symbolOneCollectionView.dataSource = self;
        _symbolOneCollectionView.scrollEnabled = NO;
        [_symbolOneCollectionView registerClass:[CBLetterCCell class] forCellWithReuseIdentifier:@"CBLetterCCell"];
        
    }
    return _symbolOneCollectionView;
}

- (UICollectionView *)symbolTwoCollectionView{
    if(!_symbolTwoCollectionView){
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
        flowlayout.itemSize = CGSizeMake((viewWidth - itemSizeSpacing*11)/10, collectionViewHeight);
        flowlayout.sectionInset = UIEdgeInsetsMake(0, [CBRatio widthRatio:21], 0, [CBRatio widthRatio:21]);
        flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _symbolTwoCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, collectionViewSpacing*2+collectionViewHeight, cb_frame.size.width, collectionViewHeight) collectionViewLayout:flowlayout];
        _symbolTwoCollectionView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
        _symbolTwoCollectionView.delegate = self;
        _symbolTwoCollectionView.dataSource = self;
        _symbolTwoCollectionView.scrollEnabled = NO;
        [_symbolTwoCollectionView registerClass:[CBLetterCCell class] forCellWithReuseIdentifier:@"CBLetterCCell"];
    }
    return _symbolTwoCollectionView;
}

- (UICollectionView *)symbolThreeCollectionView{
    if(!_symbolThreeCollectionView){
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
        flowlayout.itemSize = CGSizeMake((viewWidth - itemSizeSpacing*11)/10, collectionViewHeight);
        flowlayout.sectionInset = UIEdgeInsetsMake(0, [CBRatio widthRatio:5], 0, [CBRatio widthRatio:5]);
        flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _symbolThreeCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake([CBRatio widthRatio:55], collectionViewSpacing*3+collectionViewHeight*2, cb_frame.size.width - [CBRatio widthRatio:110], collectionViewHeight) collectionViewLayout:flowlayout];
        _symbolThreeCollectionView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
        _symbolThreeCollectionView.delegate = self;
        _symbolThreeCollectionView.dataSource = self;
        _symbolThreeCollectionView.scrollEnabled = NO;
        [_symbolThreeCollectionView registerClass:[CBLetterCCell class] forCellWithReuseIdentifier:@"CBLetterCCell"];
    }
    return _symbolThreeCollectionView;
}

- (UICollectionView *)symbolFourCollectionView{
    if(!_symbolFourCollectionView){
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
        flowlayout.itemSize = CGSizeMake((viewWidth - itemSizeSpacing*11)/10, collectionViewHeight);
        flowlayout.sectionInset = UIEdgeInsetsMake(0, [CBRatio widthRatio:5], 0, [CBRatio widthRatio:5]);
        flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _symbolFourCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake([CBRatio widthRatio:55], collectionViewSpacing*4+collectionViewHeight*3,viewWidth - [CBRatio widthRatio:92] - [CBRatio widthRatio:55], collectionViewHeight) collectionViewLayout:flowlayout];
        _symbolFourCollectionView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
        _symbolFourCollectionView.delegate = self;
        _symbolFourCollectionView.dataSource = self;
        _symbolFourCollectionView.scrollEnabled = NO;
        [_symbolFourCollectionView registerClass:[CBLetterCCell class] forCellWithReuseIdentifier:@"CBLetterCCell"];
    }
    return _symbolFourCollectionView;
}

- (UIButton *)letterBtn{
    if (!_letterBtn){
        _letterBtn = [[UIButton alloc]initWithFrame:CGRectMake(itemSizeSpacing, collectionViewSpacing*3+collectionViewHeight*2, (viewWidth - self.symbolThreeCollectionView.frame.size.width - itemSizeSpacing*2)/2, collectionViewHeight)];
        _letterBtn.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];;
        [_letterBtn setTitle:@"ABC" forState:UIControlStateNormal];
        [_letterBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _letterBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_letterBtn addTarget:self action:@selector(letterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _letterBtn.layer.cornerRadius = 4;
        _letterBtn.layer.masksToBounds = YES;
    }
    return _letterBtn;
}
-(UIButton *)deleteBtn{
    if (!_deleteBtn){
        _deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(viewWidth - [CBRatio widthRatio:55], collectionViewSpacing*3+collectionViewHeight*2, (viewWidth - self.symbolThreeCollectionView.frame.size.width - itemSizeSpacing*2)/2, collectionViewHeight)];
        _deleteBtn.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
        [_deleteBtn setImage:[UIImage imageNamed:@"Resources.bundle/keyDelete.png"] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _deleteBtn.layer.cornerRadius = 4;
        _deleteBtn.layer.masksToBounds = YES;
    }
    return _deleteBtn;
}
- (UIButton *)swithNumberBtn{
    if (!_swithNumberBtn){
        _swithNumberBtn = [[UIButton alloc]initWithFrame:CGRectMake(itemSizeSpacing, collectionViewSpacing*4+collectionViewHeight*3, (viewWidth - self.symbolThreeCollectionView.frame.size.width - itemSizeSpacing*2)/2, collectionViewHeight)];
        _swithNumberBtn.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
        [_swithNumberBtn setTitle:@"123" forState:UIControlStateNormal];
        [_swithNumberBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _swithNumberBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_swithNumberBtn addTarget:self action:@selector(swithNumberBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _swithNumberBtn.layer.cornerRadius = 4;
        _swithNumberBtn.layer.masksToBounds = YES;
    }
    return _swithNumberBtn;
}


- (UIButton *)keyboardDown{
    if (!_keyboardDown){
        _keyboardDown = [[UIButton alloc]initWithFrame:CGRectMake(self.symbolFourCollectionView.frame.size.width + self.symbolFourCollectionView.frame.origin.x, collectionViewSpacing*4+collectionViewHeight*3, [CBRatio widthRatio:97] - itemSizeSpacing*2, collectionViewHeight)];
        _keyboardDown.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
        [_keyboardDown setImage:[UIImage imageNamed:@"Resources.bundle/keyboardDown.png"] forState:UIControlStateNormal];
        [_keyboardDown addTarget:self action:@selector(keyboardDownClick) forControlEvents:UIControlEventTouchUpInside];
        _keyboardDown.layer.cornerRadius = 4;
        _keyboardDown.layer.masksToBounds = YES;
    }
    return _keyboardDown;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        cb_frame = frame;
        self.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
        [self InitializeProperty];
        [self initLetterKeyboardView];
    }
    return self;
}
#pragma mark --初始化
- (void)InitializeProperty{
    
    viewWidth = cb_frame.size.width;
    viewHeight = cb_frame.size.height;
    collectionViewSpacing = [CBRatio heightRation:10];
    collectionViewHeight = [CBRatio heightRation:42];
    itemSizeSpacing = [CBRatio widthRatio:5];
    self.inputString = @"";
    symbolOneArray = @[@"[",@"]",@"{",@"}",@"#",@"%",@"^",@"*",@"+",@"="];
    symbolTwoArray = @[@"_",@"\\",@"|",@"~",@"<",@">",@"'",@"\"",@"`"];
    symbolThreeArray = @[@".",@",",@"?",@"!",@"-",@"/",@":"];
    symbolFourArray = @[@"&",@"(",@")",@"$",@";",@"@"];
}
- (void)initLetterKeyboardView{
    [self addSubview:self.symbolOneCollectionView];
    [self addSubview:self.symbolTwoCollectionView];
    [self addSubview:self.symbolThreeCollectionView];
    [self addSubview:self.symbolFourCollectionView];
    [self addSubview:self.letterBtn];
    [self addSubview:self.deleteBtn];
    [self addSubview:self.swithNumberBtn];
    [self addSubview:self.characterBtn];
    [self addSubview:self.keyboardDown];
}

#pragma mark ---UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == self.symbolOneCollectionView){
        return symbolOneArray.count;
    }else if (collectionView == self.symbolTwoCollectionView){
        return symbolTwoArray.count;
    }else if (collectionView == self.symbolThreeCollectionView){
        return symbolThreeArray.count;
    }else {
        return symbolFourArray.count;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CBLetterCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CBLetterCCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.layer.cornerRadius = 4;
    cell.layer.masksToBounds = YES;
    if (collectionView == self.symbolOneCollectionView){
        [cell initCell:indexPath.row wihtDataSource:symbolOneArray];
    }else if (collectionView == self.symbolTwoCollectionView){
        [cell initCell:indexPath.row wihtDataSource:symbolTwoArray];
    }else if (collectionView == self.symbolThreeCollectionView){
        [cell initCell:indexPath.row wihtDataSource:symbolThreeArray];
    }else {
        [cell initCell:indexPath.row wihtDataSource:symbolFourArray];
    }
    return cell;
    
    
}

#pragma mark ---UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == self.symbolOneCollectionView){
        self.inputString = symbolOneArray[indexPath.row];
    }else if (collectionView == self.symbolTwoCollectionView){
        self.inputString = symbolTwoArray[indexPath.row];
    }else if (collectionView == self.symbolThreeCollectionView){
        self.inputString = symbolThreeArray[indexPath.row];
    }else {
        self.inputString = symbolFourArray[indexPath.row];
    }
    self.symbolKeyboardBlock(SYMBOLOUTPUTSTRING,self.inputString);
}

#pragma mark ---UICollectionViewDelegateFlowLayout
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return itemSizeSpacing;
}

#pragma mark ----btnClick  切换数字键盘
- (void)swithNumberBtnClick{
    if (self.symbolKeyboardBlock != nil){
        self.symbolKeyboardBlock(SYMBOL2NUM,@"");
    }
    
}
#pragma mark ----btnClick  切换字母键盘
- (void)letterBtnClick:(UIButton *)sender{
    if (self.symbolKeyboardBlock != nil){
        self.symbolKeyboardBlock(SYMBOL2LETTER,@"");
    }
    
}
- (void)keyboardDownClick{
    if (self.symbolKeyboardBlock != nil){
        self.symbolKeyboardBlock(SYMBOLKEYBOARDDOWN,@"");
    }
    
}
- (void)deleteBtnClick{
    if (self.symbolKeyboardBlock != nil){
        self.symbolKeyboardBlock(SYMBOLDELETE,@"");
    }
    
}


@end
