//
//  PhotoManager.h
//  InstaKilo
//
//  Created by Errol Cheong on 2017-07-12.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PhotoManager : NSObject

@property (assign, nonatomic) NSUInteger sections;
@property (strong, nonatomic) NSArray<NSString*>* photoNames;
@property (strong, nonatomic) NSMutableArray<NSMutableArray<UIImage*>*>* imageList;

-(void)getListOfPhotoNames;

-(void)sortPhotosIntoSections;

@end

