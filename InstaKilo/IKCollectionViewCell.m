//
//  IKCollectionViewCell.m
//  InstaKilo
//
//  Created by Errol Cheong on 2017-07-12.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

#import "IKCollectionViewCell.h"
#import "Photo.h"


@interface IKCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation IKCollectionViewCell

- (void)updateDisplay{
    self.imageView.image = self.photo.image;
    
}

@end
