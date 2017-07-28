//
//  CustomCollectionViewCell.m
//  InstaKilo
//
//  Created by Errol Cheong on 2017-07-14.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

#import "CustomCollectionViewCell.h"
#import "Photo.h"


@interface CustomCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *outerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *innerImageView;


@end

@implementation CustomCollectionViewCell


-(void)updateDisplay{
    self.outerImageView.image = self.photo.image;
    self.innerImageView.image = [UIImage imageNamed:@"square-frame"];
//    self.outerImageView.layer.zPosition = 100;
}

@end
