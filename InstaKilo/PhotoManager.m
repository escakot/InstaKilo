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


-(Photo*)getPhotoAtIndexPath:(NSIndexPath*)indexPath
{
    NSArray *allSectionKeys = [self.photoList allKeys];
    NSArray *sortedSectionKeys = [allSectionKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
//    NSLog(@"%@",sortedSectionKeys);
    NSString *sectionKey = sortedSectionKeys[indexPath.section];
    NSMutableArray *section = self.photoList[sectionKey];
    
    return section[indexPath.row];
}

-(void)movePhotoFromIndexPath:(NSIndexPath*)sourcePath toIndexPath:(NSIndexPath*)destinationPath
{
    NSArray *allSectionKeys = [self.photoList allKeys];
    NSArray *sortedSectionKeys = [allSectionKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    //Get and Remove Source Item
    NSString *sourceSectionKey = sortedSectionKeys[sourcePath.section];
    NSMutableArray *sourceSection = self.photoList[sourceSectionKey];
    Photo *sourcePhoto = sourceSection[sourcePath.row];
    [sourceSection removeObjectAtIndex:sourcePath.row];
    
    //Destination Item
    NSString *destinationSectionKey = sortedSectionKeys[destinationPath.section];
    NSMutableArray *destinationSection = self.photoList[destinationSectionKey];
    [destinationSection insertObject:sourcePhoto atIndex:destinationPath.row];
    
}
@end
