//
//  CBCustomLetterKeyboard.m
//  CBKeyBoard
//
//  Created by do on 2022/10/11.
//  Copyright © 2022 CBcc. All rights reserved.
//

#import "CBCustomLetterKeyboard.h"
#import "CBRatio.h"
#import "CBLetterCCell.h"

#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height

@implementation CBCustomLetterKeyboard
{
    CGRect cb_frame;
    CGFloat viewWidth;
    CGFloat viewHeight;
    CGFloat collectionViewSpacing;
    CGFloat collectionViewHeight;
    CGFloat itemSizeSpacing;
    
    NSArray <NSString*>*qpArray;
    NSArray <NSString*>*alArray;
    NSArray <NSString*>*zmArray;
    NSArray <NSString*>*symbolArray;
}

#pragma mark -lazy
- (UICollectionView *)qpCollectionView{
    if(!_qpCollectionView){
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
        flowlayout.itemSize = CGSizeMake((viewWidth - itemSizeSpacing*11)/10, collectionViewHeight);
        flowlayout.sectionInset = UIEdgeInsetsMake(0, [CBRatio widthRatio:5], 0, [CBRatio widthRatio:5]);
        flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _qpCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, collectionViewSpacing, cb_frame.size.width, collectionViewHeight) collectionViewLayout:flowlayout];
        _qpCollectionView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
        _qpCollectionView.delegate = self;
        _qpCollectionView.dataSource = self;
        _qpCollectionView.scrollEnabled = NO;
        [_qpCollectionView registerClass:[CBLetterCCell class] forCellWithReuseIdentifier:@"CBLetterCCell"];
        
    }
    return _qpCollectionView;
}

- (UICollectionView *)alCollectionView{
    if(!_alCollectionView){
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
        flowlayout.itemSize = CGSizeMake((viewWidth - itemSizeSpacing*11)/10, collectionViewHeight);
        flowlayout.sectionInset = UIEdgeInsetsMake(0, [CBRatio widthRatio:21], 0, [CBRatio widthRatio:21]);
        flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _alCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, collectionViewSpacing*2+collectionViewHeight, cb_frame.size.width, collectionViewHeight) collectionViewLayout:flowlayout];
        _alCollectionView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
        _alCollectionView.delegate = self;
        _alCollectionView.dataSource = self;
        _alCollectionView.scrollEnabled = NO;
        [_alCollectionView registerClass:[CBLetterCCell class] forCellWithReuseIdentifier:@"CBLetterCCell"];
    }
    return _alCollectionView;
}

- (UICollectionView *)zmCollectionView{
    if(!_zmCollectionView){
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
        flowlayout.itemSize = CGSizeMake((viewWidth - itemSizeSpacing*11)/10, collectionViewHeight);
        flowlayout.sectionInset = UIEdgeInsetsMake(0, [CBRatio widthRatio:5], 0, [CBRatio widthRatio:5]);
        flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _zmCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake([CBRatio widthRatio:55], collectionViewSpacing*3+collectionViewHeight*2, cb_frame.size.width - [CBRatio widthRatio:110], collectionViewHeight) collectionViewLayout:flowlayout];
        _zmCollectionView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
        _zmCollectionView.delegate = self;
        _zmCollectionView.dataSource = self;
        _zmCollectionView.scrollEnabled = NO;
        [_zmCollectionView registerClass:[CBLetterCCell class] forCellWithReuseIdentifier:@"CBLetterCCell"];
    }
    return _zmCollectionView;
}

- (UIButton *)bigSmallBtn{
    if (!_bigSmallBtn){
        _bigSmallBtn = [[UIButton alloc]initWithFrame:CGRectMake(itemSizeSpacing, collectionViewSpacing*3+collectionViewHeight*2, (viewWidth - _zmCollectionView.frame.size.width - itemSizeSpacing*2)/2, collectionViewHeight)];
        _bigSmallBtn.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
        [_bigSmallBtn setImage:[UIImage imageNamed:@"Resources.bundle/bigSmall.png"] forState:UIControlStateNormal];
        [_bigSmallBtn addTarget:self action:@selector(bigSmallBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _bigSmallBtn.layer.cornerRadius = 4;
        _bigSmallBtn.layer.masksToBounds = YES;
    }
    return _bigSmallBtn;
}
-(UIButton *)deleteBtn{
    if (!_deleteBtn){
        _deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(viewWidth - [CBRatio widthRatio:55], collectionViewSpacing*3+collectionViewHeight*2, (viewWidth - _zmCollectionView.frame.size.width - itemSizeSpacing*2)/2, collectionViewHeight)];
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
        _swithNumberBtn = [[UIButton alloc]initWithFrame:CGRectMake(itemSizeSpacing, collectionViewSpacing*4+collectionViewHeight*3, (viewWidth - _zmCollectionView.frame.size.width - itemSizeSpacing*2)/2, collectionViewHeight)];
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
- (UIButton *)characterBtn{
    if (!_characterBtn){
        _characterBtn = [[UIButton alloc]initWithFrame:CGRectMake(itemSizeSpacing*2+(viewWidth - _zmCollectionView.frame.size.width - itemSizeSpacing*2)/2, collectionViewSpacing*4+collectionViewHeight*3, (viewWidth - _zmCollectionView.frame.size.width - itemSizeSpacing*2)/2, collectionViewHeight)];
        _characterBtn.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
        [_characterBtn setTitle:@"@#&" forState:UIControlStateNormal];
        [_characterBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _characterBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_characterBtn addTarget:self action:@selector(characterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _characterBtn.layer.cornerRadius = 4;
        _characterBtn.layer.masksToBounds = YES;
    }
    return _characterBtn;
}
- (UIButton *)safeKeyboardTipBtn{
    if (!_safeKeyboardTipBtn){
        _safeKeyboardTipBtn = [[UIButton alloc]initWithFrame:CGRectMake(itemSizeSpacing*3+(cb_frame.size.width - _zmCollectionView.frame.size.width - itemSizeSpacing*2), collectionViewSpacing*4+collectionViewHeight*3, (viewWidth - (itemSizeSpacing*3+(viewWidth - _zmCollectionView.frame.size.width - itemSizeSpacing*2)) - [CBRatio widthRatio:97]), collectionViewHeight)];
        _safeKeyboardTipBtn.backgroundColor = [UIColor whiteColor];
        [_safeKeyboardTipBtn setTitle:@" " forState:UIControlStateNormal];
        [_safeKeyboardTipBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _safeKeyboardTipBtn.titleLabel.font = [UIFont systemFontOfSize:[CBRatio heightRation:16]];
        _safeKeyboardTipBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _safeKeyboardTipBtn.layer.cornerRadius = 4;
        _safeKeyboardTipBtn.layer.masksToBounds = YES;
    }
    return _safeKeyboardTipBtn;
}
- (UIButton *)keyboardDown{
    if (!_keyboardDown){
        _keyboardDown = [[UIButton alloc]initWithFrame:CGRectMake(self.safeKeyboardTipBtn.frame.size.width + self.safeKeyboardTipBtn.frame.origin.x + itemSizeSpacing, collectionViewSpacing*4+collectionViewHeight*3, [CBRatio widthRatio:97] - itemSizeSpacing*2, collectionViewHeight)];
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

- (void)InitializeProperty{

    viewWidth = cb_frame.size.width;
    viewHeight = cb_frame.size.height;
    collectionViewSpacing = [CBRatio heightRation:10];
    collectionViewHeight = [CBRatio heightRation:42];
    itemSizeSpacing = [CBRatio widthRatio:5];
    self.inputString = @"";
    qpArray = @[@"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p"];
    alArray = @[@"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l"];
    zmArray = @[@"z",@"x",@"c",@"v",@"b",@"n",@"m"];
}

#pragma mark  初始化
- (void)initLetterKeyboardView{
    [self addSubview:self.qpCollectionView];
    [self addSubview:self.alCollectionView];
    [self addSubview:self.zmCollectionView];
    [self addSubview:self.bigSmallBtn];
    [self addSubview:self.deleteBtn];
    [self addSubview:self.swithNumberBtn];
    [self addSubview:self.characterBtn];
    [self addSubview:self.safeKeyboardTipBtn];
    [self addSubview:self.keyboardDown];
}

- (void)setMark:(NSString *)mark {
    [self.safeKeyboardTipBtn setTitle:mark forState:UIControlStateNormal];
}

#pragma mark ---UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == self.qpCollectionView){
        return qpArray.count;
    }else if (collectionView == self.alCollectionView){
        return alArray.count;
    }else if (collectionView == self.zmCollectionView){
        return zmArray.count;
    }else {
        return symbolArray.count;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CBLetterCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CBLetterCCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.layer.cornerRadius = 4;
    cell.layer.masksToBounds = YES;
    if (collectionView == self.qpCollectionView){
        [cell initCell:indexPath.row wihtDataSource:qpArray];
    }else if (collectionView == self.alCollectionView){
        [cell initCell:indexPath.row wihtDataSource:alArray];
    }else{
        [cell initCell:indexPath.row wihtDataSource:zmArray];
    }
    return cell;
    
    
}

#pragma mark ---UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.qpCollectionView){
        self.inputString = qpArray[indexPath.row];
    }else if (collectionView == self.alCollectionView){
        self.inputString = alArray[indexPath.row];
    }else{
        self.inputString = zmArray[indexPath.row];
    }    
    self.letterKeyboardBlock(LETTEROUTPUTSTRING,self.inputString);
}

#pragma mark ---UICollectionViewDelegateFlowLayout
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return itemSizeSpacing;
}

#pragma mark ----btnClick
- (void)swithNumberBtnClick{
    self.letterKeyboardBlock(LETTER2NUM,@"");
}
- (void)bigSmallBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected){
        self.bigSmallBtn.backgroundColor = [UIColor whiteColor];
        qpArray = @[@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P"];
        alArray = @[@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L"];
        zmArray = @[@"Z",@"X",@"C",@"V",@"B",@"N",@"M"];
    }else {
        self.bigSmallBtn.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];;
        qpArray = @[@"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p"];
        alArray = @[@"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l"];
        zmArray = @[@"z",@"x",@"c",@"v",@"b",@"n",@"m"];
    }
    [self.qpCollectionView reloadData];
    [self.alCollectionView reloadData];
    [self.zmCollectionView reloadData];
}

#pragma mark --切换符号键盘
- (void)characterBtnClick:(UIButton *)sender{
    if (self.letterKeyboardBlock != nil){
        self.letterKeyboardBlock(LETTER2SYMBOL,@"");
    }
    
}
- (void)keyboardDownClick{
    if (self.letterKeyboardBlock != nil){
        self.letterKeyboardBlock(LETTERKEYBOARDDOWN,@"");
    }
    
}
- (void)deleteBtnClick{
    if (self.letterKeyboardBlock != nil){
        self.letterKeyboardBlock(LETTERDELETE,@"");
    }
}


@end
