//
//  CustomCollectionViewCell.h
//  InstaKilo
//
//  Created by Errol Cheong on 2017-07-14.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Photo;
@interface CustomCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) Photo* photo;
-(void)updateDisplay;

@end
