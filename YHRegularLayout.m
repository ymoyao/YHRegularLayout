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
-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray* attributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    for(int i = 1; i < [attributes count]; ++i) {
        //当前attributes
        UICollectionViewLayoutAttributes *currentLayoutAttributes = attributes[i];
        //上一个attributes
        UICollectionViewLayoutAttributes *prevLayoutAttributes = attributes[i - 1];
        //固定间距
        NSInteger maximumInteritemSpacing = self.minimumInteritemSpacing;
        //固定行距
        NSInteger maximumLineSpacing = self.minimumLineSpacing;
        //获取上个item的最大X 和 Y
        NSInteger originX = CGRectGetMaxX(prevLayoutAttributes.frame);
        NSInteger originY = CGRectGetMaxY(prevLayoutAttributes.frame);
   
        
        if(originX + maximumInteritemSpacing + currentLayoutAttributes.frame.size.width + self.sectionInset.right < self.collectionViewContentSize.width ) {                      //判断添加上该item 是否回超过屏幕
            CGRect frame = currentLayoutAttributes.frame;
            if (currentLayoutAttributes.indexPath.section == prevLayoutAttributes.indexPath.section) {//同一组才需要改x
                frame.origin.x = originX + maximumInteritemSpacing;
            }
            currentLayoutAttributes.frame = frame;
        }else if (currentLayoutAttributes.representedElementKind != nil){//头部视图不做处理
            
        }
        else{                                                            //换行情况
            CGRect frame = currentLayoutAttributes.frame;
            if (currentLayoutAttributes.indexPath.section == prevLayoutAttributes.indexPath.section) {//同一组才需要改y
                frame.origin.y = originY + maximumLineSpacing;
            }
            frame.origin.x = self.sectionInset.left;
            currentLayoutAttributes.frame = frame;
        }
    }
    return attributes;
}

@end
