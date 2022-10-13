//
//  CBLetterCCell.h
//  CBKeyBoard
//
//  Created by do on 2022/10/9.
//  Copyright © 2022 CBcc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBLetterCCell : UICollectionViewCell

@property (nonatomic,strong) UILabel *lab;

- (void)initCell:(NSInteger)index wihtDataSource:(NSArray<NSString*>*)data;

@end

NS_ASSUME_NONNULL_END
