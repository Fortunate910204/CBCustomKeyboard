//
//  CBLetterCCell.m
//  CBKeyBoard
//
//  Created by do on 2022/10/9.
//  Copyright © 2022 CBcc. All rights reserved.
//

#import "CBLetterCCell.h"

@implementation CBLetterCCell

- (UILabel *)lab {
    if (!_lab){
        _lab = [[UILabel alloc] init];
        _lab.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _lab.textColor = [UIColor blackColor];
        _lab.font = [UIFont systemFontOfSize:16];
        _lab.textAlignment = NSTextAlignmentCenter;
    }
    return _lab;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)initCell:(NSInteger)index wihtDataSource:(NSArray<NSString*>*)data{
    [self addSubview:self.lab];
    _lab.text = data[index];
    
}

@end
