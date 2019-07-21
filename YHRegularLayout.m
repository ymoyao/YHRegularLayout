//
//  BCSearchVCItemLayout.m
//  bookclub
//
//  Created by MasterFly on 2017/7/4.
//  Copyright © 2017年 luke.chen. All rights reserved.
//

#import "YHRegularLayout.h"

@implementation YHRegularLayout

/**
 重写父类布局item的方法
 
 @param rect rect
 @return @[UICollectionViewLayoutAttributes]
 */
- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray* attributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    for(int i = 0; i < [attributes count]; ++i) {
        //当前attributes
        UICollectionViewLayoutAttributes *currentLayoutAttributes = attributes[i];
        //上一个attributes
        UICollectionViewLayoutAttributes *prevLayoutAttributes;
        if (i == 0) {
            prevLayoutAttributes = nil;
        } else {
            prevLayoutAttributes = attributes[i - 1];
        }
        //固定间距
        CGFloat maximumInteritemSpacing = self.minimumInteritemSpacing;
        //固定行距
        CGFloat maximumLineSpacing = self.minimumLineSpacing;
        //获取上个item的最大X 和 Y
        CGFloat originX = [self fetchOriginXWithCurrentLayoutAttributes:currentLayoutAttributes prevLayoutAttributes:prevLayoutAttributes];
        CGFloat originY = [self fetchOriginYWithCurrentLayoutAttributes:currentLayoutAttributes prevLayoutAttributes:prevLayoutAttributes];
        CGFloat currentAttWidth = currentLayoutAttributes.frame.size.width;
        CGFloat sectionInsetLeft = self.sectionInset.left;
        CGFloat sectionInsetRight = self.sectionInset.right;
        CGFloat contentSizeWidth = self.collectionViewContentSize.width;
        
        if (currentLayoutAttributes.representedElementKind == nil) {                                                                    //头部视图不做处理
            if (originX + maximumInteritemSpacing + currentAttWidth + sectionInsetRight < contentSizeWidth) {                           //判断添加上该item 是否回超过屏幕
                CGRect frame = currentLayoutAttributes.frame;
                if (currentLayoutAttributes.indexPath.section == prevLayoutAttributes.indexPath.section) {                              //同一组才需要改x
                    frame.origin.x = originX + (prevLayoutAttributes?maximumInteritemSpacing:0);
                }
                currentLayoutAttributes.frame = frame;
            } else {                                                                                                                     //换行情况
                CGRect frame = currentLayoutAttributes.frame;
                if (currentLayoutAttributes.indexPath.section == prevLayoutAttributes.indexPath.section) {                               //同一组才需要改y
                    frame.origin.y = originY + (prevLayoutAttributes?maximumLineSpacing:0);
                    frame.origin.x = sectionInsetLeft;
                    if (currentAttWidth + sectionInsetLeft + sectionInsetRight > contentSizeWidth) {                                     //单个label 超出屏幕
                        frame.size.width = contentSizeWidth - sectionInsetLeft - sectionInsetRight;
                    }
                }
                currentLayoutAttributes.frame = frame;
            }
        }
    }
    return attributes;
}


- (CGFloat)fetchOriginXWithCurrentLayoutAttributes:(UICollectionViewLayoutAttributes *)currentLayoutAttributes prevLayoutAttributes:(UICollectionViewLayoutAttributes *)prevLayoutAttributes {
    if (prevLayoutAttributes == nil) {
        return self.sectionInset.left;
    }
    return CGRectGetMaxX(prevLayoutAttributes.frame);
}

- (CGFloat)fetchOriginYWithCurrentLayoutAttributes:(UICollectionViewLayoutAttributes *)currentLayoutAttributes prevLayoutAttributes:(UICollectionViewLayoutAttributes *)prevLayoutAttributes {
    if (prevLayoutAttributes == nil) {
        return CGRectGetMinY(currentLayoutAttributes.frame);
    }
    return CGRectGetMaxY(prevLayoutAttributes.frame);
}

@end
