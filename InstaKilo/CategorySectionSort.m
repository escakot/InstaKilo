//
//  CategorySectionSort.m
//  InstaKilo
//
//  Created by Errol Cheong on 2017-07-12.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

#import "CategorySectionSort.h"
#import "Photo.h"

@implementation CategorySectionSort

-(NSMutableDictionary *)sortPhotosIntoSections:(NSArray *)photoNames
{
    NSMutableDictionary *photoList = [[NSMutableDictionary alloc] init];
    NSMutableArray *uncategorized = [[NSMutableArray alloc] init];
    for (NSString* photo in photoNames)
    {
        NSString* photoLocation = [NSString stringWithFormat:@"%@%@", @"Images/", photo];
        NSArray *sectionWords = [photo componentsSeparatedByString:@"-"];
        //Check for section identifier @"-"
        if (sectionWords.count >= 2){
            //Check if section already exists
            NSString *key = [sectionWords[0] lowercaseString];
            if([photoList objectForKey:key])
            {
                NSMutableArray *addToSection = photoList[key];
                Photo *newPhoto = [[Photo alloc] init];
                newPhoto.name = sectionWords[1];
                newPhoto.image = [UIImage imageNamed:photoLocation];
                [addToSection addObject:newPhoto];
                
            //Create new NSArray with key
            } else {
                NSMutableArray *newSection = [[NSMutableArray alloc] init];
                Photo *newPhoto = [[Photo alloc] init];
                newPhoto.name = sectionWords[1];
                newPhoto.image = [UIImage imageNamed:photoLocation];
                [newSection addObject:newPhoto];
                [photoList setObject:newSection forKey:key];
            }
        } else {
            Photo *newPhoto = [[Photo alloc] init];
            newPhoto.name = photo;
            newPhoto.image = [UIImage imageNamed:photoLocation];
            [uncategorized addObject:newPhoto];
        }
    }
    [photoList setObject:uncategorized forKey:@"uncategorized"];
    NSLog(@"%@",photoList);
    return photoList;
}

@end
