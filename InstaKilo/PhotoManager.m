//
//  PhotoManager.m
//  InstaKilo
//
//  Created by Errol Cheong on 2017-07-12.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

#import "PhotoManager.h"
#import "Photo.h"

@implementation PhotoManager


- (instancetype)init
{
    self = [super init];
    if (self) {
        _photoNames = [self getListOfPhotoNames];
    }
    return self;
}

-(NSArray*)getListOfPhotoNames
{
    NSArray *photoNames = [[NSMutableArray alloc] init];
    __block NSString *imagesURLString = [[NSString alloc] init];
    [[[NSBundle mainBundle] pathsForResourcesOfType:nil inDirectory:nil] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
    {
        if ([obj hasSuffix:@"Images"])
        {
            imagesURLString = obj;
            NSLog(@"%@",obj);
        }
    }];
    NSFileManager *fileManager= [NSFileManager defaultManager];
    photoNames = [fileManager contentsOfDirectoryAtPath:imagesURLString error:nil];
    
    return photoNames;
}

-(void)getSectionData{
    self.photoList = [self.delegate sortPhotosIntoSections:self.photoNames];
}


-(Photo*)getPhotoAtIndexPath:(NSIndexPath*)indexPath{
    NSArray *allSectionKeys = [self.photoList allKeys];
    NSArray *sortedSectionKeys = [allSectionKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
//    NSLog(@"%@",sortedSectionKeys);
    NSString *sectionKey = sortedSectionKeys[indexPath.section];
    NSMutableArray *section = self.photoList[sectionKey];
    
    return section[indexPath.row];
}

@end
