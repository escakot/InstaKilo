//
//  PhotoManager.h
//  InstaKilo
//
//  Created by Errol Cheong on 2017-07-12.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Photo;

@protocol PhotoManagerDelegate <NSObject>

-(NSMutableDictionary*)sortPhotosIntoSections:(NSArray*)photoNames;

@end


@interface PhotoManager : NSObject

@property (strong, nonatomic) NSArray<NSString*>* photoNames;
@property (strong, nonatomic) NSMutableDictionary<NSString*,NSMutableArray*>* photoList;
@property (weak, nonatomic) id<PhotoManagerDelegate> delegate;

-(NSArray*)getListOfPhotoNames;

-(void)getSectionData;

-(Photo*)getPhotoAtIndexPath:(NSIndexPath*)indexPath;

-(void)movePhotoFromIndexPath:(NSIndexPath*)sourcePath toIndexPath:(NSIndexPath*)destinationPath;


@end

