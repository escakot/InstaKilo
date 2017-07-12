//
//  IKCollectionViewCell.h
//  InstaKilo
//
//  Created by Errol Cheong on 2017-07-12.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IKCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UIImage* image;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (void)updateDisplay;

@end
