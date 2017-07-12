//
//  Photo.h
//  InstaKilo
//
//  Created by Errol Cheong on 2017-07-12.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Photo : NSObject

@property (nonatomic, strong) UIImage* image;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* location;

@end
