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

-(void)getListOfPhotoNames
{
    self.photoNames = [[NSMutableArray alloc] init];
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
    self.photoNames = [fileManager contentsOfDirectoryAtPath:imagesURLString error:nil];
    
}

-(void)sortPhotosIntoSections
{
    NSMutableDictionary *sectionItems = [[NSMutableDictionary alloc] init];
    NSMutableArray *uncategorized = [[NSMutableArray alloc] init];
    for (NSString* photo in self.photoNames)
    {
        NSArray *sectionWords = [photo componentsSeparatedByString:@"-"];
        //Check for section identifier @"-"
        if (sectionWords.count >= 2){
            //Check if section already exists
            NSString *key = sectionWords[0];
            if([sectionItems objectForKey:key])
            {
                NSMutableArray *addToSection = sectionItems[key];
                Photo *newPhoto = [[Photo alloc] init];
                newPhoto.name = sectionWords[1];
                newPhoto.image = [UIImage imageNamed:photo];
                [addToSection addObject:newPhoto];
                
            //Create new NSArray with key
            } else {
                NSMutableArray *newSection = [[NSMutableArray alloc] init];
                [sectionItems setObject:newSection forKey:key];
                Photo *newPhoto = [[Photo alloc] init];
                newPhoto.name = sectionWords[1];
                newPhoto.image = [UIImage imageNamed:photo];
                [newSection addObject:newPhoto];
            }
        } else {
            Photo *newPhoto = [[Photo alloc] init];
            newPhoto.name = photo;
            newPhoto.image = [UIImage imageNamed:photo];
            [uncategorized addObject:newPhoto];
        }
    }
    NSLog(@"%@",sectionItems);
    
    
}

@end
