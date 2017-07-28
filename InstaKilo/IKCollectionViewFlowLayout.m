//
//  IKCollectionViewFlowLayout.m
//  InstaKilo
//
//  Created by Errol Cheong on 2017-07-13.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

#import "IKCollectionViewFlowLayout.h"

@interface IKCollectionViewFlowLayout ()

@property (strong, nonatomic) NSMutableArray *layoutAttributes;

@end

#define degreesToRadians(x) (M_PI * x / 180.0)
@implementation IKCollectionViewFlowLayout



//-(void)prepareLayout{
//    //Populate layout attributes here
//    self.layoutAttributes = [@[] mutableCopy];
//    NSUInteger xItemCounter = 0;
//    NSUInteger yItemCounter = 0;
//    CGFloat itemWidth = 80;
//    CGFloat itemHeight = 100;
//    CGFloat itemSpacing = 20;
//    CGFloat xEdgeSpacing;
//    CGFloat xItemAndSpaceSize = itemWidth;
//    
//    
//    //Calculate Initial Layout
//    CGSize viewSize = self.collectionView.frame.size;
//    while (xItemAndSpaceSize < viewSize.width){
//        xItemAndSpaceSize += itemSpacing;
//        xItemAndSpaceSize += itemWidth;
//    }
//    xEdgeSpacing = (viewSize.width - xItemAndSpaceSize) / 2;
//    
//    
//    
//    for (NSInteger section = 0; section < [self.collectionView numberOfSections]; section++)
//    {
//        xItemCounter = 0;
//        yItemCounter++;
//        for (NSInteger item = 0; item < [self.collectionView numberOfItemsInSection:section]; item++)
//        {
//            UICollectionViewLayoutAttributes *attributes;
//            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
//            attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//            
//            
//            //Rect Size
////            if (xSizeCounter * )
//            CGFloat originX = xEdgeSpacing + (xItemCounter * (itemWidth + itemSpacing));
//            CGFloat originY = 0 + (yItemCounter * (itemHeight + itemSpacing));
//            
//            if (originX > viewSize.width)
//            {
//                yItemCounter++;
//                xItemCounter = 0;
//            }
//            
//            attributes.frame = CGRectMake(originX,
//                                          originY,
//                                          itemWidth,
//                                          itemHeight);
//            
//            xItemCounter++;
//            
//            //Angle
////            CGFloat angle = degreesToRadians((float)rand() / RAND_MAX * 20);
////            attributes.transform = CGAffineTransformMakeRotation(angle);
//            
//            [self.layoutAttributes addObject:attributes];
//        }
//    }
//}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *layouts = [super layoutAttributesForElementsInRect:rect];
    
    for (UICollectionViewLayoutAttributes *attributes in layouts) {
//        float randomValue = ((float)rand() / (float)RAND_MAX);
        float randArcValue = (float)arc4random_uniform(100000000) / 100000000.00 * 0.5;
        float angle = degreesToRadians((randArcValue) - 1);
        attributes.transform = CGAffineTransformMakeRotation(angle);
    }
    
    return layouts;
//    return self.layoutAttributes;
}


//- (CGSize)collectionViewContentSize {
//  return CGSizeMake(100000, 100000);
//}

@end
